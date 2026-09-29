import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppearanceSettingsBloc
    extends Bloc<AppearanceSettingsEvent, AppearanceSettingsState> {
  AppearanceSettingsBloc({
    required this.appRouter,
    required this.getAppearancePreferencesUseCase,
    required this.setAppearancePreferencesUseCase,
    required this.installedFontsPort,
  }) : super(const AppearanceSettingsState.loading()) {
    on<AppearanceSettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final GetAppearancePreferencesUseCase getAppearancePreferencesUseCase;
  final SetAppearancePreferencesUseCase setAppearancePreferencesUseCase;
  final InstalledFontsPort installedFontsPort;

  Future<void> _onEvent(
    AppearanceSettingsEvent event,
    Emitter<AppearanceSettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const AppearanceSettingsState.loading());
        try {
          final prefs = await getAppearancePreferencesUseCase();
          final availableFonts = await _buildAvailableFonts(prefs.appFont);
          await installedFontsPort.loadFont(prefs.appFont.familyId);
          emit(
            AppearanceSettingsState.loaded(
              savedThemeColorArgb: prefs.themeColorArgb,
              savedTextColor: prefs.textColor,
              savedShowTileSeparators: prefs.showTileSeparators,
              savedAppFont: prefs.appFont,
              draftThemeColorArgb: prefs.themeColorArgb,
              draftTextColor: prefs.textColor,
              draftShowTileSeparators: prefs.showTileSeparators,
              draftAppFont: prefs.appFont,
              availableFonts: availableFonts,
            ),
          );
        } catch (error) {
          emit(AppearanceSettingsState.error(message: error.toString()));
        }
      },
      backTapped: () async {
        _pop(emit);
      },
      saveTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || !state.hasUnsavedChanges) {
          return;
        }

        emit(current.copyWith(isSaving: true, actionErrorMessage: null));
        try {
          await setAppearancePreferencesUseCase(
            AppearancePreferences(
              themeColorArgb: current.draftThemeColorArgb,
              textColor: current.draftTextColor,
              showTileSeparators: current.draftShowTileSeparators,
              appFont: current.draftAppFont,
            ),
          );
          emit(
            current.copyWith(
              savedThemeColorArgb: current.draftThemeColorArgb,
              savedTextColor: current.draftTextColor,
              savedShowTileSeparators: current.draftShowTileSeparators,
              savedAppFont: current.draftAppFont,
              isSaving: false,
              actionErrorMessage: null,
            ),
          );
        } catch (error) {
          emit(
            current.copyWith(
              isSaving: false,
              actionErrorMessage: error.toString(),
            ),
          );
        }
      },
      themeColorChanged: (colorArgb) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftThemeColorArgb: colorArgb,
            actionErrorMessage: null,
          ),
        );
      },
      textColorChanged: (textColor) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftTextColor: textColor,
            actionErrorMessage: null,
          ),
        );
      },
      tileSeparatorsChanged: (show) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftShowTileSeparators: show,
            actionErrorMessage: null,
          ),
        );
      },
      appFontChanged: (appFont) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        await installedFontsPort.loadFont(appFont.familyId);
        emit(
          current.copyWith(
            draftAppFont: appFont,
            actionErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<List<LauncherAppFont>> _buildAvailableFonts(
    LauncherAppFont selected,
  ) async {
    final deviceFonts = await installedFontsPort.listFonts();
    final fonts = <LauncherAppFont>[
      LauncherAppFont.system,
      ...deviceFonts.map((font) => LauncherAppFont(font.familyId)),
    ];

    if (!selected.isSystem &&
        fonts.every((font) => font.familyId != selected.familyId)) {
      fonts.add(selected);
    }

    return fonts;
  }

  void _pop(Emitter<AppearanceSettingsState> emit) {
    final loaded = state.mapOrNull(loaded: (value) => value);
    if (loaded != null) {
      emit(
        AppearanceSettingsState.closing(
          draftThemeColorArgb: loaded.draftThemeColorArgb,
          draftTextColor: loaded.draftTextColor,
          draftShowTileSeparators: loaded.draftShowTileSeparators,
          draftAppFont: loaded.draftAppFont,
        ),
      );
    }
    appRouter.pop();
  }
}

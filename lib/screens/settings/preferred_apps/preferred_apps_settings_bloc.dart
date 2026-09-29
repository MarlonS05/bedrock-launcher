import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferredAppsSettingsBloc
    extends Bloc<PreferredAppsSettingsEvent, PreferredAppsSettingsState> {
  PreferredAppsSettingsBloc({
    required this.appRouter,
    required this.getPreferredAppsPreferencesUseCase,
    required this.setPreferredAppsPreferencesUseCase,
    required this.listInstalledAppsUseCase,
  }) : super(const PreferredAppsSettingsState.loading()) {
    on<PreferredAppsSettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final GetPreferredAppsPreferencesUseCase getPreferredAppsPreferencesUseCase;
  final SetPreferredAppsPreferencesUseCase setPreferredAppsPreferencesUseCase;
  final ListInstalledAppsUseCase listInstalledAppsUseCase;

  Future<void> _onEvent(
    PreferredAppsSettingsEvent event,
    Emitter<PreferredAppsSettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const PreferredAppsSettingsState.loading());
        try {
          final prefs = await getPreferredAppsPreferencesUseCase();
          final apps = await listInstalledAppsUseCase();
          final sortedApps = [...apps]
            ..sort(
              (a, b) => a.displayName.toLowerCase().compareTo(
                    b.displayName.toLowerCase(),
                  ),
            );
          emit(
            PreferredAppsSettingsState.loaded(
              installedApps: sortedApps,
              savedClockPackageName: prefs.clockPackageName,
              savedPhonePackageName: prefs.phonePackageName,
              savedCameraPackageName: prefs.cameraPackageName,
              savedGalleryPackageName: prefs.galleryPackageName,
              draftClockPackageName: prefs.clockPackageName,
              draftPhonePackageName: prefs.phonePackageName,
              draftCameraPackageName: prefs.cameraPackageName,
              draftGalleryPackageName: prefs.galleryPackageName,
            ),
          );
        } catch (error) {
          emit(PreferredAppsSettingsState.error(message: error.toString()));
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
          await setPreferredAppsPreferencesUseCase(
            PreferredAppsPreferences(
              clockPackageName: current.draftClockPackageName,
              phonePackageName: current.draftPhonePackageName,
              cameraPackageName: current.draftCameraPackageName,
              galleryPackageName: current.draftGalleryPackageName,
            ),
          );
          emit(
            current.copyWith(
              savedClockPackageName: current.draftClockPackageName,
              savedPhonePackageName: current.draftPhonePackageName,
              savedCameraPackageName: current.draftCameraPackageName,
              savedGalleryPackageName: current.draftGalleryPackageName,
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
      clockAppChanged: (packageName) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftClockPackageName: packageName,
            actionErrorMessage: null,
          ),
        );
      },
      phoneAppChanged: (packageName) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftPhonePackageName: packageName,
            actionErrorMessage: null,
          ),
        );
      },
      cameraAppChanged: (packageName) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftCameraPackageName: packageName,
            actionErrorMessage: null,
          ),
        );
      },
      galleryAppChanged: (packageName) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftGalleryPackageName: packageName,
            actionErrorMessage: null,
          ),
        );
      },
    );
  }

  void _pop(Emitter<PreferredAppsSettingsState> emit) {
    final loaded = state.mapOrNull(loaded: (value) => value);
    if (loaded != null) {
      emit(
        PreferredAppsSettingsState.closing(
          draftClockPackageName: loaded.draftClockPackageName,
          draftPhonePackageName: loaded.draftPhonePackageName,
          draftCameraPackageName: loaded.draftCameraPackageName,
          draftGalleryPackageName: loaded.draftGalleryPackageName,
        ),
      );
    }
    appRouter.pop();
  }
}

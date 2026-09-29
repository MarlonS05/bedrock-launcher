import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appearance_settings_state.freezed.dart';

@freezed
sealed class AppearanceSettingsState with _$AppearanceSettingsState {
  const AppearanceSettingsState._();

  const factory AppearanceSettingsState.loading() = _Loading;

  const factory AppearanceSettingsState.loaded({
    required int savedThemeColorArgb,
    required LauncherTextColor savedTextColor,
    required bool savedShowTileSeparators,
    required LauncherAppFont savedAppFont,
    required int draftThemeColorArgb,
    required LauncherTextColor draftTextColor,
    required bool draftShowTileSeparators,
    required LauncherAppFont draftAppFont,
    @Default(<LauncherAppFont>[LauncherAppFont.system])
    List<LauncherAppFont> availableFonts,
    @Default(false) bool isSaving,
    String? actionErrorMessage,
  }) = _Loaded;

  const factory AppearanceSettingsState.closing({
    required int draftThemeColorArgb,
    required LauncherTextColor draftTextColor,
    required bool draftShowTileSeparators,
    required LauncherAppFont draftAppFont,
  }) = _Closing;

  const factory AppearanceSettingsState.error({
    required String message,
  }) = _Error;

  bool get hasUnsavedChanges => maybeMap(
        loaded: (state) =>
            state.savedThemeColorArgb != state.draftThemeColorArgb ||
            state.savedTextColor != state.draftTextColor ||
            state.savedShowTileSeparators != state.draftShowTileSeparators ||
            state.savedAppFont != state.draftAppFont,
        orElse: () => false,
      );
}

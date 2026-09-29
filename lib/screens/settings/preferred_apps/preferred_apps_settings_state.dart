import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferred_apps_settings_state.freezed.dart';

@freezed
sealed class PreferredAppsSettingsState with _$PreferredAppsSettingsState {
  const PreferredAppsSettingsState._();

  const factory PreferredAppsSettingsState.loading() = _Loading;

  const factory PreferredAppsSettingsState.loaded({
    required List<LauncherApp> installedApps,
    required String? savedClockPackageName,
    required String? savedPhonePackageName,
    required String? savedCameraPackageName,
    required String? savedGalleryPackageName,
    required String? draftClockPackageName,
    required String? draftPhonePackageName,
    required String? draftCameraPackageName,
    required String? draftGalleryPackageName,
    @Default(false) bool isSaving,
    String? actionErrorMessage,
  }) = _Loaded;

  const factory PreferredAppsSettingsState.closing({
    required String? draftClockPackageName,
    required String? draftPhonePackageName,
    required String? draftCameraPackageName,
    required String? draftGalleryPackageName,
  }) = _Closing;

  const factory PreferredAppsSettingsState.error({
    required String message,
  }) = _Error;

  bool get hasUnsavedChanges => maybeMap(
        loaded: (state) =>
            state.savedClockPackageName != state.draftClockPackageName ||
            state.savedPhonePackageName != state.draftPhonePackageName ||
            state.savedCameraPackageName != state.draftCameraPackageName ||
            state.savedGalleryPackageName != state.draftGalleryPackageName,
        orElse: () => false,
      );
}

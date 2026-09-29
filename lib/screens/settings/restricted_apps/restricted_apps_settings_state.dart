import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restricted_apps_settings_state.freezed.dart';

@freezed
sealed class RestrictedAppsSettingsState with _$RestrictedAppsSettingsState {
  const RestrictedAppsSettingsState._();

  const factory RestrictedAppsSettingsState.loading() = _Loading;

  const factory RestrictedAppsSettingsState.loaded({
    required List<LauncherApp> installedApps,
    required Set<String> savedRestrictedPackageNames,
    required Set<String> draftRestrictedPackageNames,
    @Default(false) bool isSaving,
    String? actionErrorMessage,
  }) = _Loaded;

  const factory RestrictedAppsSettingsState.closing({
    required Set<String> draftRestrictedPackageNames,
  }) = _Closing;

  const factory RestrictedAppsSettingsState.error({
    required String message,
  }) = _Error;

  bool get hasUnsavedChanges => maybeMap(
        loaded: (state) => !_samePackageSet(
          state.savedRestrictedPackageNames,
          state.draftRestrictedPackageNames,
        ),
        orElse: () => false,
      );

  static bool _samePackageSet(Set<String> a, Set<String> b) {
    if (a.length != b.length) {
      return false;
    }
    return a.containsAll(b);
  }
}

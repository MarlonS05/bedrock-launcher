import 'package:freezed_annotation/freezed_annotation.dart';

part 'restricted_apps_settings_event.freezed.dart';

@freezed
sealed class RestrictedAppsSettingsEvent with _$RestrictedAppsSettingsEvent {
  const factory RestrictedAppsSettingsEvent.started() = _Started;

  const factory RestrictedAppsSettingsEvent.backTapped() = _BackTapped;

  const factory RestrictedAppsSettingsEvent.saveTapped() = _SaveTapped;

  const factory RestrictedAppsSettingsEvent.restrictedAppToggled(
    String packageName,
  ) = _RestrictedAppToggled;
}

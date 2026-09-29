import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions_settings_event.freezed.dart';

@freezed
sealed class PermissionsSettingsEvent with _$PermissionsSettingsEvent {
  const factory PermissionsSettingsEvent.started() = _Started;

  const factory PermissionsSettingsEvent.backTapped() = _BackTapped;

  const factory PermissionsSettingsEvent.openDefaultLauncherTapped() =
      _OpenDefaultLauncherTapped;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = _Started;

  const factory SettingsEvent.backTapped() = _BackTapped;

  const factory SettingsEvent.appearanceTapped() = _AppearanceTapped;

  const factory SettingsEvent.permissionsTapped() = _PermissionsTapped;

  const factory SettingsEvent.favoritesTapped() = _FavoritesTapped;

  const factory SettingsEvent.preferredAppsTapped() = _PreferredAppsTapped;

  const factory SettingsEvent.restrictedAppsTapped() = _RestrictedAppsTapped;
}

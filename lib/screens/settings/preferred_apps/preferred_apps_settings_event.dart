import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferred_apps_settings_event.freezed.dart';

@freezed
sealed class PreferredAppsSettingsEvent with _$PreferredAppsSettingsEvent {
  const factory PreferredAppsSettingsEvent.started() = _Started;

  const factory PreferredAppsSettingsEvent.backTapped() = _BackTapped;

  const factory PreferredAppsSettingsEvent.saveTapped() = _SaveTapped;

  const factory PreferredAppsSettingsEvent.clockAppChanged(
    String? packageName,
  ) = _ClockAppChanged;

  const factory PreferredAppsSettingsEvent.phoneAppChanged(
    String? packageName,
  ) = _PhoneAppChanged;

  const factory PreferredAppsSettingsEvent.cameraAppChanged(
    String? packageName,
  ) = _CameraAppChanged;

  const factory PreferredAppsSettingsEvent.galleryAppChanged(
    String? packageName,
  ) = _GalleryAppChanged;
}

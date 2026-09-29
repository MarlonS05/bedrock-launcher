import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions_settings_state.freezed.dart';

@freezed
sealed class PermissionsSettingsState with _$PermissionsSettingsState {
  const factory PermissionsSettingsState.loaded({
    @Default(false) bool isOpening,
    String? actionErrorMessage,
  }) = _Loaded;

  const factory PermissionsSettingsState.closing() = _Closing;

  const factory PermissionsSettingsState.error({
    required String message,
  }) = _Error;
}

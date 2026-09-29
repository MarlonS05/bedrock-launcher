import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.loaded() = _Loaded;

  const factory SettingsState.closing() = _Closing;

  const factory SettingsState.error({required String message}) = _Error;
}

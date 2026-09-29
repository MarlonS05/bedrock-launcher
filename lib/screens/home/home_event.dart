import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;

  const factory HomeEvent.appTapped(int index) = _AppTapped;

  const factory HomeEvent.browserSwipeUpDetected() = _BrowserSwipeUpDetected;

  const factory HomeEvent.allAppsTapped() = _AllAppsTapped;

  const factory HomeEvent.settingsTapped() = _SettingsTapped;

  const factory HomeEvent.phoneTapped() = _PhoneTapped;

  const factory HomeEvent.cameraTapped() = _CameraTapped;

  const factory HomeEvent.cameraLongPressed() = _CameraLongPressed;

  const factory HomeEvent.clockTapped() = _ClockTapped;

  const factory HomeEvent.retryTapped() = _RetryTapped;

  const factory HomeEvent.appearancePreferencesChanged() =
      _AppearancePreferencesChanged;

  const factory HomeEvent.batteryRefreshRequested() =
      _BatteryRefreshRequested;

  const factory HomeEvent.restrictedLaunchConfirmed() =
      _RestrictedLaunchConfirmed;

  const factory HomeEvent.restrictedLaunchCancelled() =
      _RestrictedLaunchCancelled;

  const factory HomeEvent.browserDoubleTapped() = _BrowserDoubleTapped;

  const factory HomeEvent.mathPracticeDismissed() = _MathPracticeDismissed;
}

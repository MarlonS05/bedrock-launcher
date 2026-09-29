// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _AppTapped value)?  appTapped,TResult Function( _BrowserSwipeUpDetected value)?  browserSwipeUpDetected,TResult Function( _AllAppsTapped value)?  allAppsTapped,TResult Function( _SettingsTapped value)?  settingsTapped,TResult Function( _PhoneTapped value)?  phoneTapped,TResult Function( _CameraTapped value)?  cameraTapped,TResult Function( _CameraLongPressed value)?  cameraLongPressed,TResult Function( _ClockTapped value)?  clockTapped,TResult Function( _RetryTapped value)?  retryTapped,TResult Function( _AppearancePreferencesChanged value)?  appearancePreferencesChanged,TResult Function( _BatteryRefreshRequested value)?  batteryRefreshRequested,TResult Function( _RestrictedLaunchConfirmed value)?  restrictedLaunchConfirmed,TResult Function( _RestrictedLaunchCancelled value)?  restrictedLaunchCancelled,TResult Function( _BrowserDoubleTapped value)?  browserDoubleTapped,TResult Function( _MathPracticeDismissed value)?  mathPracticeDismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AppTapped() when appTapped != null:
return appTapped(_that);case _BrowserSwipeUpDetected() when browserSwipeUpDetected != null:
return browserSwipeUpDetected(_that);case _AllAppsTapped() when allAppsTapped != null:
return allAppsTapped(_that);case _SettingsTapped() when settingsTapped != null:
return settingsTapped(_that);case _PhoneTapped() when phoneTapped != null:
return phoneTapped(_that);case _CameraTapped() when cameraTapped != null:
return cameraTapped(_that);case _CameraLongPressed() when cameraLongPressed != null:
return cameraLongPressed(_that);case _ClockTapped() when clockTapped != null:
return clockTapped(_that);case _RetryTapped() when retryTapped != null:
return retryTapped(_that);case _AppearancePreferencesChanged() when appearancePreferencesChanged != null:
return appearancePreferencesChanged(_that);case _BatteryRefreshRequested() when batteryRefreshRequested != null:
return batteryRefreshRequested(_that);case _RestrictedLaunchConfirmed() when restrictedLaunchConfirmed != null:
return restrictedLaunchConfirmed(_that);case _RestrictedLaunchCancelled() when restrictedLaunchCancelled != null:
return restrictedLaunchCancelled(_that);case _BrowserDoubleTapped() when browserDoubleTapped != null:
return browserDoubleTapped(_that);case _MathPracticeDismissed() when mathPracticeDismissed != null:
return mathPracticeDismissed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _AppTapped value)  appTapped,required TResult Function( _BrowserSwipeUpDetected value)  browserSwipeUpDetected,required TResult Function( _AllAppsTapped value)  allAppsTapped,required TResult Function( _SettingsTapped value)  settingsTapped,required TResult Function( _PhoneTapped value)  phoneTapped,required TResult Function( _CameraTapped value)  cameraTapped,required TResult Function( _CameraLongPressed value)  cameraLongPressed,required TResult Function( _ClockTapped value)  clockTapped,required TResult Function( _RetryTapped value)  retryTapped,required TResult Function( _AppearancePreferencesChanged value)  appearancePreferencesChanged,required TResult Function( _BatteryRefreshRequested value)  batteryRefreshRequested,required TResult Function( _RestrictedLaunchConfirmed value)  restrictedLaunchConfirmed,required TResult Function( _RestrictedLaunchCancelled value)  restrictedLaunchCancelled,required TResult Function( _BrowserDoubleTapped value)  browserDoubleTapped,required TResult Function( _MathPracticeDismissed value)  mathPracticeDismissed,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _AppTapped():
return appTapped(_that);case _BrowserSwipeUpDetected():
return browserSwipeUpDetected(_that);case _AllAppsTapped():
return allAppsTapped(_that);case _SettingsTapped():
return settingsTapped(_that);case _PhoneTapped():
return phoneTapped(_that);case _CameraTapped():
return cameraTapped(_that);case _CameraLongPressed():
return cameraLongPressed(_that);case _ClockTapped():
return clockTapped(_that);case _RetryTapped():
return retryTapped(_that);case _AppearancePreferencesChanged():
return appearancePreferencesChanged(_that);case _BatteryRefreshRequested():
return batteryRefreshRequested(_that);case _RestrictedLaunchConfirmed():
return restrictedLaunchConfirmed(_that);case _RestrictedLaunchCancelled():
return restrictedLaunchCancelled(_that);case _BrowserDoubleTapped():
return browserDoubleTapped(_that);case _MathPracticeDismissed():
return mathPracticeDismissed(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _AppTapped value)?  appTapped,TResult? Function( _BrowserSwipeUpDetected value)?  browserSwipeUpDetected,TResult? Function( _AllAppsTapped value)?  allAppsTapped,TResult? Function( _SettingsTapped value)?  settingsTapped,TResult? Function( _PhoneTapped value)?  phoneTapped,TResult? Function( _CameraTapped value)?  cameraTapped,TResult? Function( _CameraLongPressed value)?  cameraLongPressed,TResult? Function( _ClockTapped value)?  clockTapped,TResult? Function( _RetryTapped value)?  retryTapped,TResult? Function( _AppearancePreferencesChanged value)?  appearancePreferencesChanged,TResult? Function( _BatteryRefreshRequested value)?  batteryRefreshRequested,TResult? Function( _RestrictedLaunchConfirmed value)?  restrictedLaunchConfirmed,TResult? Function( _RestrictedLaunchCancelled value)?  restrictedLaunchCancelled,TResult? Function( _BrowserDoubleTapped value)?  browserDoubleTapped,TResult? Function( _MathPracticeDismissed value)?  mathPracticeDismissed,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AppTapped() when appTapped != null:
return appTapped(_that);case _BrowserSwipeUpDetected() when browserSwipeUpDetected != null:
return browserSwipeUpDetected(_that);case _AllAppsTapped() when allAppsTapped != null:
return allAppsTapped(_that);case _SettingsTapped() when settingsTapped != null:
return settingsTapped(_that);case _PhoneTapped() when phoneTapped != null:
return phoneTapped(_that);case _CameraTapped() when cameraTapped != null:
return cameraTapped(_that);case _CameraLongPressed() when cameraLongPressed != null:
return cameraLongPressed(_that);case _ClockTapped() when clockTapped != null:
return clockTapped(_that);case _RetryTapped() when retryTapped != null:
return retryTapped(_that);case _AppearancePreferencesChanged() when appearancePreferencesChanged != null:
return appearancePreferencesChanged(_that);case _BatteryRefreshRequested() when batteryRefreshRequested != null:
return batteryRefreshRequested(_that);case _RestrictedLaunchConfirmed() when restrictedLaunchConfirmed != null:
return restrictedLaunchConfirmed(_that);case _RestrictedLaunchCancelled() when restrictedLaunchCancelled != null:
return restrictedLaunchCancelled(_that);case _BrowserDoubleTapped() when browserDoubleTapped != null:
return browserDoubleTapped(_that);case _MathPracticeDismissed() when mathPracticeDismissed != null:
return mathPracticeDismissed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int index)?  appTapped,TResult Function()?  browserSwipeUpDetected,TResult Function()?  allAppsTapped,TResult Function()?  settingsTapped,TResult Function()?  phoneTapped,TResult Function()?  cameraTapped,TResult Function()?  cameraLongPressed,TResult Function()?  clockTapped,TResult Function()?  retryTapped,TResult Function()?  appearancePreferencesChanged,TResult Function()?  batteryRefreshRequested,TResult Function()?  restrictedLaunchConfirmed,TResult Function()?  restrictedLaunchCancelled,TResult Function()?  browserDoubleTapped,TResult Function()?  mathPracticeDismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AppTapped() when appTapped != null:
return appTapped(_that.index);case _BrowserSwipeUpDetected() when browserSwipeUpDetected != null:
return browserSwipeUpDetected();case _AllAppsTapped() when allAppsTapped != null:
return allAppsTapped();case _SettingsTapped() when settingsTapped != null:
return settingsTapped();case _PhoneTapped() when phoneTapped != null:
return phoneTapped();case _CameraTapped() when cameraTapped != null:
return cameraTapped();case _CameraLongPressed() when cameraLongPressed != null:
return cameraLongPressed();case _ClockTapped() when clockTapped != null:
return clockTapped();case _RetryTapped() when retryTapped != null:
return retryTapped();case _AppearancePreferencesChanged() when appearancePreferencesChanged != null:
return appearancePreferencesChanged();case _BatteryRefreshRequested() when batteryRefreshRequested != null:
return batteryRefreshRequested();case _RestrictedLaunchConfirmed() when restrictedLaunchConfirmed != null:
return restrictedLaunchConfirmed();case _RestrictedLaunchCancelled() when restrictedLaunchCancelled != null:
return restrictedLaunchCancelled();case _BrowserDoubleTapped() when browserDoubleTapped != null:
return browserDoubleTapped();case _MathPracticeDismissed() when mathPracticeDismissed != null:
return mathPracticeDismissed();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int index)  appTapped,required TResult Function()  browserSwipeUpDetected,required TResult Function()  allAppsTapped,required TResult Function()  settingsTapped,required TResult Function()  phoneTapped,required TResult Function()  cameraTapped,required TResult Function()  cameraLongPressed,required TResult Function()  clockTapped,required TResult Function()  retryTapped,required TResult Function()  appearancePreferencesChanged,required TResult Function()  batteryRefreshRequested,required TResult Function()  restrictedLaunchConfirmed,required TResult Function()  restrictedLaunchCancelled,required TResult Function()  browserDoubleTapped,required TResult Function()  mathPracticeDismissed,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _AppTapped():
return appTapped(_that.index);case _BrowserSwipeUpDetected():
return browserSwipeUpDetected();case _AllAppsTapped():
return allAppsTapped();case _SettingsTapped():
return settingsTapped();case _PhoneTapped():
return phoneTapped();case _CameraTapped():
return cameraTapped();case _CameraLongPressed():
return cameraLongPressed();case _ClockTapped():
return clockTapped();case _RetryTapped():
return retryTapped();case _AppearancePreferencesChanged():
return appearancePreferencesChanged();case _BatteryRefreshRequested():
return batteryRefreshRequested();case _RestrictedLaunchConfirmed():
return restrictedLaunchConfirmed();case _RestrictedLaunchCancelled():
return restrictedLaunchCancelled();case _BrowserDoubleTapped():
return browserDoubleTapped();case _MathPracticeDismissed():
return mathPracticeDismissed();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int index)?  appTapped,TResult? Function()?  browserSwipeUpDetected,TResult? Function()?  allAppsTapped,TResult? Function()?  settingsTapped,TResult? Function()?  phoneTapped,TResult? Function()?  cameraTapped,TResult? Function()?  cameraLongPressed,TResult? Function()?  clockTapped,TResult? Function()?  retryTapped,TResult? Function()?  appearancePreferencesChanged,TResult? Function()?  batteryRefreshRequested,TResult? Function()?  restrictedLaunchConfirmed,TResult? Function()?  restrictedLaunchCancelled,TResult? Function()?  browserDoubleTapped,TResult? Function()?  mathPracticeDismissed,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AppTapped() when appTapped != null:
return appTapped(_that.index);case _BrowserSwipeUpDetected() when browserSwipeUpDetected != null:
return browserSwipeUpDetected();case _AllAppsTapped() when allAppsTapped != null:
return allAppsTapped();case _SettingsTapped() when settingsTapped != null:
return settingsTapped();case _PhoneTapped() when phoneTapped != null:
return phoneTapped();case _CameraTapped() when cameraTapped != null:
return cameraTapped();case _CameraLongPressed() when cameraLongPressed != null:
return cameraLongPressed();case _ClockTapped() when clockTapped != null:
return clockTapped();case _RetryTapped() when retryTapped != null:
return retryTapped();case _AppearancePreferencesChanged() when appearancePreferencesChanged != null:
return appearancePreferencesChanged();case _BatteryRefreshRequested() when batteryRefreshRequested != null:
return batteryRefreshRequested();case _RestrictedLaunchConfirmed() when restrictedLaunchConfirmed != null:
return restrictedLaunchConfirmed();case _RestrictedLaunchCancelled() when restrictedLaunchCancelled != null:
return restrictedLaunchCancelled();case _BrowserDoubleTapped() when browserDoubleTapped != null:
return browserDoubleTapped();case _MathPracticeDismissed() when mathPracticeDismissed != null:
return mathPracticeDismissed();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements HomeEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.started()';
}


}




/// @nodoc


class _AppTapped implements HomeEvent {
  const _AppTapped(this.index);
  

 final  int index;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppTappedCopyWith<_AppTapped> get copyWith => __$AppTappedCopyWithImpl<_AppTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTapped&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'HomeEvent.appTapped(index: $index)';
}


}

/// @nodoc
abstract mixin class _$AppTappedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$AppTappedCopyWith(_AppTapped value, $Res Function(_AppTapped) _then) = __$AppTappedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$AppTappedCopyWithImpl<$Res>
    implements _$AppTappedCopyWith<$Res> {
  __$AppTappedCopyWithImpl(this._self, this._then);

  final _AppTapped _self;
  final $Res Function(_AppTapped) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_AppTapped(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _BrowserSwipeUpDetected implements HomeEvent {
  const _BrowserSwipeUpDetected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowserSwipeUpDetected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.browserSwipeUpDetected()';
}


}




/// @nodoc


class _AllAppsTapped implements HomeEvent {
  const _AllAppsTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllAppsTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.allAppsTapped()';
}


}




/// @nodoc


class _SettingsTapped implements HomeEvent {
  const _SettingsTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.settingsTapped()';
}


}




/// @nodoc


class _PhoneTapped implements HomeEvent {
  const _PhoneTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.phoneTapped()';
}


}




/// @nodoc


class _CameraTapped implements HomeEvent {
  const _CameraTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.cameraTapped()';
}


}




/// @nodoc


class _CameraLongPressed implements HomeEvent {
  const _CameraLongPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraLongPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.cameraLongPressed()';
}


}




/// @nodoc


class _ClockTapped implements HomeEvent {
  const _ClockTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClockTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.clockTapped()';
}


}




/// @nodoc


class _RetryTapped implements HomeEvent {
  const _RetryTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.retryTapped()';
}


}




/// @nodoc


class _AppearancePreferencesChanged implements HomeEvent {
  const _AppearancePreferencesChanged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppearancePreferencesChanged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.appearancePreferencesChanged()';
}


}




/// @nodoc


class _BatteryRefreshRequested implements HomeEvent {
  const _BatteryRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatteryRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.batteryRefreshRequested()';
}


}




/// @nodoc


class _RestrictedLaunchConfirmed implements HomeEvent {
  const _RestrictedLaunchConfirmed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedLaunchConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.restrictedLaunchConfirmed()';
}


}




/// @nodoc


class _RestrictedLaunchCancelled implements HomeEvent {
  const _RestrictedLaunchCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedLaunchCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.restrictedLaunchCancelled()';
}


}




/// @nodoc


class _BrowserDoubleTapped implements HomeEvent {
  const _BrowserDoubleTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowserDoubleTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.browserDoubleTapped()';
}


}




/// @nodoc


class _MathPracticeDismissed implements HomeEvent {
  const _MathPracticeDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MathPracticeDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.mathPracticeDismissed()';
}


}




// dart format on

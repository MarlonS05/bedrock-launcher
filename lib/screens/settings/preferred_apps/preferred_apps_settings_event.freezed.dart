// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferred_apps_settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreferredAppsSettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreferredAppsSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsEvent()';
}


}

/// @nodoc
class $PreferredAppsSettingsEventCopyWith<$Res>  {
$PreferredAppsSettingsEventCopyWith(PreferredAppsSettingsEvent _, $Res Function(PreferredAppsSettingsEvent) __);
}


/// Adds pattern-matching-related methods to [PreferredAppsSettingsEvent].
extension PreferredAppsSettingsEventPatterns on PreferredAppsSettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BackTapped value)?  backTapped,TResult Function( _SaveTapped value)?  saveTapped,TResult Function( _ClockAppChanged value)?  clockAppChanged,TResult Function( _PhoneAppChanged value)?  phoneAppChanged,TResult Function( _CameraAppChanged value)?  cameraAppChanged,TResult Function( _GalleryAppChanged value)?  galleryAppChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _ClockAppChanged() when clockAppChanged != null:
return clockAppChanged(_that);case _PhoneAppChanged() when phoneAppChanged != null:
return phoneAppChanged(_that);case _CameraAppChanged() when cameraAppChanged != null:
return cameraAppChanged(_that);case _GalleryAppChanged() when galleryAppChanged != null:
return galleryAppChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BackTapped value)  backTapped,required TResult Function( _SaveTapped value)  saveTapped,required TResult Function( _ClockAppChanged value)  clockAppChanged,required TResult Function( _PhoneAppChanged value)  phoneAppChanged,required TResult Function( _CameraAppChanged value)  cameraAppChanged,required TResult Function( _GalleryAppChanged value)  galleryAppChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BackTapped():
return backTapped(_that);case _SaveTapped():
return saveTapped(_that);case _ClockAppChanged():
return clockAppChanged(_that);case _PhoneAppChanged():
return phoneAppChanged(_that);case _CameraAppChanged():
return cameraAppChanged(_that);case _GalleryAppChanged():
return galleryAppChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BackTapped value)?  backTapped,TResult? Function( _SaveTapped value)?  saveTapped,TResult? Function( _ClockAppChanged value)?  clockAppChanged,TResult? Function( _PhoneAppChanged value)?  phoneAppChanged,TResult? Function( _CameraAppChanged value)?  cameraAppChanged,TResult? Function( _GalleryAppChanged value)?  galleryAppChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _ClockAppChanged() when clockAppChanged != null:
return clockAppChanged(_that);case _PhoneAppChanged() when phoneAppChanged != null:
return phoneAppChanged(_that);case _CameraAppChanged() when cameraAppChanged != null:
return cameraAppChanged(_that);case _GalleryAppChanged() when galleryAppChanged != null:
return galleryAppChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  backTapped,TResult Function()?  saveTapped,TResult Function( String? packageName)?  clockAppChanged,TResult Function( String? packageName)?  phoneAppChanged,TResult Function( String? packageName)?  cameraAppChanged,TResult Function( String? packageName)?  galleryAppChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _ClockAppChanged() when clockAppChanged != null:
return clockAppChanged(_that.packageName);case _PhoneAppChanged() when phoneAppChanged != null:
return phoneAppChanged(_that.packageName);case _CameraAppChanged() when cameraAppChanged != null:
return cameraAppChanged(_that.packageName);case _GalleryAppChanged() when galleryAppChanged != null:
return galleryAppChanged(_that.packageName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  backTapped,required TResult Function()  saveTapped,required TResult Function( String? packageName)  clockAppChanged,required TResult Function( String? packageName)  phoneAppChanged,required TResult Function( String? packageName)  cameraAppChanged,required TResult Function( String? packageName)  galleryAppChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BackTapped():
return backTapped();case _SaveTapped():
return saveTapped();case _ClockAppChanged():
return clockAppChanged(_that.packageName);case _PhoneAppChanged():
return phoneAppChanged(_that.packageName);case _CameraAppChanged():
return cameraAppChanged(_that.packageName);case _GalleryAppChanged():
return galleryAppChanged(_that.packageName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  backTapped,TResult? Function()?  saveTapped,TResult? Function( String? packageName)?  clockAppChanged,TResult? Function( String? packageName)?  phoneAppChanged,TResult? Function( String? packageName)?  cameraAppChanged,TResult? Function( String? packageName)?  galleryAppChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _ClockAppChanged() when clockAppChanged != null:
return clockAppChanged(_that.packageName);case _PhoneAppChanged() when phoneAppChanged != null:
return phoneAppChanged(_that.packageName);case _CameraAppChanged() when cameraAppChanged != null:
return cameraAppChanged(_that.packageName);case _GalleryAppChanged() when galleryAppChanged != null:
return galleryAppChanged(_that.packageName);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements PreferredAppsSettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsEvent.started()';
}


}




/// @nodoc


class _BackTapped implements PreferredAppsSettingsEvent {
  const _BackTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsEvent.backTapped()';
}


}




/// @nodoc


class _SaveTapped implements PreferredAppsSettingsEvent {
  const _SaveTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsEvent.saveTapped()';
}


}




/// @nodoc


class _ClockAppChanged implements PreferredAppsSettingsEvent {
  const _ClockAppChanged(this.packageName);
  

 final  String? packageName;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClockAppChangedCopyWith<_ClockAppChanged> get copyWith => __$ClockAppChangedCopyWithImpl<_ClockAppChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClockAppChanged&&(identical(other.packageName, packageName) || other.packageName == packageName));
}


@override
int get hashCode => Object.hash(runtimeType,packageName);

@override
String toString() {
  return 'PreferredAppsSettingsEvent.clockAppChanged(packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$ClockAppChangedCopyWith<$Res> implements $PreferredAppsSettingsEventCopyWith<$Res> {
  factory _$ClockAppChangedCopyWith(_ClockAppChanged value, $Res Function(_ClockAppChanged) _then) = __$ClockAppChangedCopyWithImpl;
@useResult
$Res call({
 String? packageName
});




}
/// @nodoc
class __$ClockAppChangedCopyWithImpl<$Res>
    implements _$ClockAppChangedCopyWith<$Res> {
  __$ClockAppChangedCopyWithImpl(this._self, this._then);

  final _ClockAppChanged _self;
  final $Res Function(_ClockAppChanged) _then;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageName = freezed,}) {
  return _then(_ClockAppChanged(
freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _PhoneAppChanged implements PreferredAppsSettingsEvent {
  const _PhoneAppChanged(this.packageName);
  

 final  String? packageName;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneAppChangedCopyWith<_PhoneAppChanged> get copyWith => __$PhoneAppChangedCopyWithImpl<_PhoneAppChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneAppChanged&&(identical(other.packageName, packageName) || other.packageName == packageName));
}


@override
int get hashCode => Object.hash(runtimeType,packageName);

@override
String toString() {
  return 'PreferredAppsSettingsEvent.phoneAppChanged(packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$PhoneAppChangedCopyWith<$Res> implements $PreferredAppsSettingsEventCopyWith<$Res> {
  factory _$PhoneAppChangedCopyWith(_PhoneAppChanged value, $Res Function(_PhoneAppChanged) _then) = __$PhoneAppChangedCopyWithImpl;
@useResult
$Res call({
 String? packageName
});




}
/// @nodoc
class __$PhoneAppChangedCopyWithImpl<$Res>
    implements _$PhoneAppChangedCopyWith<$Res> {
  __$PhoneAppChangedCopyWithImpl(this._self, this._then);

  final _PhoneAppChanged _self;
  final $Res Function(_PhoneAppChanged) _then;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageName = freezed,}) {
  return _then(_PhoneAppChanged(
freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CameraAppChanged implements PreferredAppsSettingsEvent {
  const _CameraAppChanged(this.packageName);
  

 final  String? packageName;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraAppChangedCopyWith<_CameraAppChanged> get copyWith => __$CameraAppChangedCopyWithImpl<_CameraAppChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraAppChanged&&(identical(other.packageName, packageName) || other.packageName == packageName));
}


@override
int get hashCode => Object.hash(runtimeType,packageName);

@override
String toString() {
  return 'PreferredAppsSettingsEvent.cameraAppChanged(packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$CameraAppChangedCopyWith<$Res> implements $PreferredAppsSettingsEventCopyWith<$Res> {
  factory _$CameraAppChangedCopyWith(_CameraAppChanged value, $Res Function(_CameraAppChanged) _then) = __$CameraAppChangedCopyWithImpl;
@useResult
$Res call({
 String? packageName
});




}
/// @nodoc
class __$CameraAppChangedCopyWithImpl<$Res>
    implements _$CameraAppChangedCopyWith<$Res> {
  __$CameraAppChangedCopyWithImpl(this._self, this._then);

  final _CameraAppChanged _self;
  final $Res Function(_CameraAppChanged) _then;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageName = freezed,}) {
  return _then(_CameraAppChanged(
freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _GalleryAppChanged implements PreferredAppsSettingsEvent {
  const _GalleryAppChanged(this.packageName);
  

 final  String? packageName;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryAppChangedCopyWith<_GalleryAppChanged> get copyWith => __$GalleryAppChangedCopyWithImpl<_GalleryAppChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryAppChanged&&(identical(other.packageName, packageName) || other.packageName == packageName));
}


@override
int get hashCode => Object.hash(runtimeType,packageName);

@override
String toString() {
  return 'PreferredAppsSettingsEvent.galleryAppChanged(packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$GalleryAppChangedCopyWith<$Res> implements $PreferredAppsSettingsEventCopyWith<$Res> {
  factory _$GalleryAppChangedCopyWith(_GalleryAppChanged value, $Res Function(_GalleryAppChanged) _then) = __$GalleryAppChangedCopyWithImpl;
@useResult
$Res call({
 String? packageName
});




}
/// @nodoc
class __$GalleryAppChangedCopyWithImpl<$Res>
    implements _$GalleryAppChangedCopyWith<$Res> {
  __$GalleryAppChangedCopyWithImpl(this._self, this._then);

  final _GalleryAppChanged _self;
  final $Res Function(_GalleryAppChanged) _then;

/// Create a copy of PreferredAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageName = freezed,}) {
  return _then(_GalleryAppChanged(
freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferred_apps_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreferredAppsSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreferredAppsSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsState()';
}


}

/// @nodoc
class $PreferredAppsSettingsStateCopyWith<$Res>  {
$PreferredAppsSettingsStateCopyWith(PreferredAppsSettingsState _, $Res Function(PreferredAppsSettingsState) __);
}


/// Adds pattern-matching-related methods to [PreferredAppsSettingsState].
extension PreferredAppsSettingsStatePatterns on PreferredAppsSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Closing value)?  closing,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Closing() when closing != null:
return closing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Closing value)  closing,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Closing():
return closing(_that);case _Error():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Closing value)?  closing,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Closing() when closing != null:
return closing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<LauncherApp> installedApps,  String? savedClockPackageName,  String? savedPhonePackageName,  String? savedCameraPackageName,  String? savedGalleryPackageName,  String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult Function( String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName)?  closing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.installedApps,_that.savedClockPackageName,_that.savedPhonePackageName,_that.savedCameraPackageName,_that.savedGalleryPackageName,_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<LauncherApp> installedApps,  String? savedClockPackageName,  String? savedPhonePackageName,  String? savedCameraPackageName,  String? savedGalleryPackageName,  String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName,  bool isSaving,  String? actionErrorMessage)  loaded,required TResult Function( String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName)  closing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.installedApps,_that.savedClockPackageName,_that.savedPhonePackageName,_that.savedCameraPackageName,_that.savedGalleryPackageName,_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName,_that.isSaving,_that.actionErrorMessage);case _Closing():
return closing(_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName);case _Error():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<LauncherApp> installedApps,  String? savedClockPackageName,  String? savedPhonePackageName,  String? savedCameraPackageName,  String? savedGalleryPackageName,  String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult? Function( String? draftClockPackageName,  String? draftPhonePackageName,  String? draftCameraPackageName,  String? draftGalleryPackageName)?  closing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.installedApps,_that.savedClockPackageName,_that.savedPhonePackageName,_that.savedCameraPackageName,_that.savedGalleryPackageName,_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftClockPackageName,_that.draftPhonePackageName,_that.draftCameraPackageName,_that.draftGalleryPackageName);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loading extends PreferredAppsSettingsState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PreferredAppsSettingsState.loading()';
}


}




/// @nodoc


class _Loaded extends PreferredAppsSettingsState {
  const _Loaded({required final  List<LauncherApp> installedApps, required this.savedClockPackageName, required this.savedPhonePackageName, required this.savedCameraPackageName, required this.savedGalleryPackageName, required this.draftClockPackageName, required this.draftPhonePackageName, required this.draftCameraPackageName, required this.draftGalleryPackageName, this.isSaving = false, this.actionErrorMessage}): _installedApps = installedApps,super._();
  

 final  List<LauncherApp> _installedApps;
 List<LauncherApp> get installedApps {
  if (_installedApps is EqualUnmodifiableListView) return _installedApps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installedApps);
}

 final  String? savedClockPackageName;
 final  String? savedPhonePackageName;
 final  String? savedCameraPackageName;
 final  String? savedGalleryPackageName;
 final  String? draftClockPackageName;
 final  String? draftPhonePackageName;
 final  String? draftCameraPackageName;
 final  String? draftGalleryPackageName;
@JsonKey() final  bool isSaving;
 final  String? actionErrorMessage;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._installedApps, _installedApps)&&(identical(other.savedClockPackageName, savedClockPackageName) || other.savedClockPackageName == savedClockPackageName)&&(identical(other.savedPhonePackageName, savedPhonePackageName) || other.savedPhonePackageName == savedPhonePackageName)&&(identical(other.savedCameraPackageName, savedCameraPackageName) || other.savedCameraPackageName == savedCameraPackageName)&&(identical(other.savedGalleryPackageName, savedGalleryPackageName) || other.savedGalleryPackageName == savedGalleryPackageName)&&(identical(other.draftClockPackageName, draftClockPackageName) || other.draftClockPackageName == draftClockPackageName)&&(identical(other.draftPhonePackageName, draftPhonePackageName) || other.draftPhonePackageName == draftPhonePackageName)&&(identical(other.draftCameraPackageName, draftCameraPackageName) || other.draftCameraPackageName == draftCameraPackageName)&&(identical(other.draftGalleryPackageName, draftGalleryPackageName) || other.draftGalleryPackageName == draftGalleryPackageName)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_installedApps),savedClockPackageName,savedPhonePackageName,savedCameraPackageName,savedGalleryPackageName,draftClockPackageName,draftPhonePackageName,draftCameraPackageName,draftGalleryPackageName,isSaving,actionErrorMessage);

@override
String toString() {
  return 'PreferredAppsSettingsState.loaded(installedApps: $installedApps, savedClockPackageName: $savedClockPackageName, savedPhonePackageName: $savedPhonePackageName, savedCameraPackageName: $savedCameraPackageName, savedGalleryPackageName: $savedGalleryPackageName, draftClockPackageName: $draftClockPackageName, draftPhonePackageName: $draftPhonePackageName, draftCameraPackageName: $draftCameraPackageName, draftGalleryPackageName: $draftGalleryPackageName, isSaving: $isSaving, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $PreferredAppsSettingsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<LauncherApp> installedApps, String? savedClockPackageName, String? savedPhonePackageName, String? savedCameraPackageName, String? savedGalleryPackageName, String? draftClockPackageName, String? draftPhonePackageName, String? draftCameraPackageName, String? draftGalleryPackageName, bool isSaving, String? actionErrorMessage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? installedApps = null,Object? savedClockPackageName = freezed,Object? savedPhonePackageName = freezed,Object? savedCameraPackageName = freezed,Object? savedGalleryPackageName = freezed,Object? draftClockPackageName = freezed,Object? draftPhonePackageName = freezed,Object? draftCameraPackageName = freezed,Object? draftGalleryPackageName = freezed,Object? isSaving = null,Object? actionErrorMessage = freezed,}) {
  return _then(_Loaded(
installedApps: null == installedApps ? _self._installedApps : installedApps // ignore: cast_nullable_to_non_nullable
as List<LauncherApp>,savedClockPackageName: freezed == savedClockPackageName ? _self.savedClockPackageName : savedClockPackageName // ignore: cast_nullable_to_non_nullable
as String?,savedPhonePackageName: freezed == savedPhonePackageName ? _self.savedPhonePackageName : savedPhonePackageName // ignore: cast_nullable_to_non_nullable
as String?,savedCameraPackageName: freezed == savedCameraPackageName ? _self.savedCameraPackageName : savedCameraPackageName // ignore: cast_nullable_to_non_nullable
as String?,savedGalleryPackageName: freezed == savedGalleryPackageName ? _self.savedGalleryPackageName : savedGalleryPackageName // ignore: cast_nullable_to_non_nullable
as String?,draftClockPackageName: freezed == draftClockPackageName ? _self.draftClockPackageName : draftClockPackageName // ignore: cast_nullable_to_non_nullable
as String?,draftPhonePackageName: freezed == draftPhonePackageName ? _self.draftPhonePackageName : draftPhonePackageName // ignore: cast_nullable_to_non_nullable
as String?,draftCameraPackageName: freezed == draftCameraPackageName ? _self.draftCameraPackageName : draftCameraPackageName // ignore: cast_nullable_to_non_nullable
as String?,draftGalleryPackageName: freezed == draftGalleryPackageName ? _self.draftGalleryPackageName : draftGalleryPackageName // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Closing extends PreferredAppsSettingsState {
  const _Closing({required this.draftClockPackageName, required this.draftPhonePackageName, required this.draftCameraPackageName, required this.draftGalleryPackageName}): super._();
  

 final  String? draftClockPackageName;
 final  String? draftPhonePackageName;
 final  String? draftCameraPackageName;
 final  String? draftGalleryPackageName;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClosingCopyWith<_Closing> get copyWith => __$ClosingCopyWithImpl<_Closing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Closing&&(identical(other.draftClockPackageName, draftClockPackageName) || other.draftClockPackageName == draftClockPackageName)&&(identical(other.draftPhonePackageName, draftPhonePackageName) || other.draftPhonePackageName == draftPhonePackageName)&&(identical(other.draftCameraPackageName, draftCameraPackageName) || other.draftCameraPackageName == draftCameraPackageName)&&(identical(other.draftGalleryPackageName, draftGalleryPackageName) || other.draftGalleryPackageName == draftGalleryPackageName));
}


@override
int get hashCode => Object.hash(runtimeType,draftClockPackageName,draftPhonePackageName,draftCameraPackageName,draftGalleryPackageName);

@override
String toString() {
  return 'PreferredAppsSettingsState.closing(draftClockPackageName: $draftClockPackageName, draftPhonePackageName: $draftPhonePackageName, draftCameraPackageName: $draftCameraPackageName, draftGalleryPackageName: $draftGalleryPackageName)';
}


}

/// @nodoc
abstract mixin class _$ClosingCopyWith<$Res> implements $PreferredAppsSettingsStateCopyWith<$Res> {
  factory _$ClosingCopyWith(_Closing value, $Res Function(_Closing) _then) = __$ClosingCopyWithImpl;
@useResult
$Res call({
 String? draftClockPackageName, String? draftPhonePackageName, String? draftCameraPackageName, String? draftGalleryPackageName
});




}
/// @nodoc
class __$ClosingCopyWithImpl<$Res>
    implements _$ClosingCopyWith<$Res> {
  __$ClosingCopyWithImpl(this._self, this._then);

  final _Closing _self;
  final $Res Function(_Closing) _then;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftClockPackageName = freezed,Object? draftPhonePackageName = freezed,Object? draftCameraPackageName = freezed,Object? draftGalleryPackageName = freezed,}) {
  return _then(_Closing(
draftClockPackageName: freezed == draftClockPackageName ? _self.draftClockPackageName : draftClockPackageName // ignore: cast_nullable_to_non_nullable
as String?,draftPhonePackageName: freezed == draftPhonePackageName ? _self.draftPhonePackageName : draftPhonePackageName // ignore: cast_nullable_to_non_nullable
as String?,draftCameraPackageName: freezed == draftCameraPackageName ? _self.draftCameraPackageName : draftCameraPackageName // ignore: cast_nullable_to_non_nullable
as String?,draftGalleryPackageName: freezed == draftGalleryPackageName ? _self.draftGalleryPackageName : draftGalleryPackageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error extends PreferredAppsSettingsState {
  const _Error({required this.message}): super._();
  

 final  String message;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PreferredAppsSettingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PreferredAppsSettingsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PreferredAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restricted_apps_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestrictedAppsSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestrictedAppsSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsState()';
}


}

/// @nodoc
class $RestrictedAppsSettingsStateCopyWith<$Res>  {
$RestrictedAppsSettingsStateCopyWith(RestrictedAppsSettingsState _, $Res Function(RestrictedAppsSettingsState) __);
}


/// Adds pattern-matching-related methods to [RestrictedAppsSettingsState].
extension RestrictedAppsSettingsStatePatterns on RestrictedAppsSettingsState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<LauncherApp> installedApps,  Set<String> savedRestrictedPackageNames,  Set<String> draftRestrictedPackageNames,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult Function( Set<String> draftRestrictedPackageNames)?  closing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.installedApps,_that.savedRestrictedPackageNames,_that.draftRestrictedPackageNames,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftRestrictedPackageNames);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<LauncherApp> installedApps,  Set<String> savedRestrictedPackageNames,  Set<String> draftRestrictedPackageNames,  bool isSaving,  String? actionErrorMessage)  loaded,required TResult Function( Set<String> draftRestrictedPackageNames)  closing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.installedApps,_that.savedRestrictedPackageNames,_that.draftRestrictedPackageNames,_that.isSaving,_that.actionErrorMessage);case _Closing():
return closing(_that.draftRestrictedPackageNames);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<LauncherApp> installedApps,  Set<String> savedRestrictedPackageNames,  Set<String> draftRestrictedPackageNames,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult? Function( Set<String> draftRestrictedPackageNames)?  closing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.installedApps,_that.savedRestrictedPackageNames,_that.draftRestrictedPackageNames,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftRestrictedPackageNames);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loading extends RestrictedAppsSettingsState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsState.loading()';
}


}




/// @nodoc


class _Loaded extends RestrictedAppsSettingsState {
  const _Loaded({required final  List<LauncherApp> installedApps, required final  Set<String> savedRestrictedPackageNames, required final  Set<String> draftRestrictedPackageNames, this.isSaving = false, this.actionErrorMessage}): _installedApps = installedApps,_savedRestrictedPackageNames = savedRestrictedPackageNames,_draftRestrictedPackageNames = draftRestrictedPackageNames,super._();
  

 final  List<LauncherApp> _installedApps;
 List<LauncherApp> get installedApps {
  if (_installedApps is EqualUnmodifiableListView) return _installedApps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installedApps);
}

 final  Set<String> _savedRestrictedPackageNames;
 Set<String> get savedRestrictedPackageNames {
  if (_savedRestrictedPackageNames is EqualUnmodifiableSetView) return _savedRestrictedPackageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_savedRestrictedPackageNames);
}

 final  Set<String> _draftRestrictedPackageNames;
 Set<String> get draftRestrictedPackageNames {
  if (_draftRestrictedPackageNames is EqualUnmodifiableSetView) return _draftRestrictedPackageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_draftRestrictedPackageNames);
}

@JsonKey() final  bool isSaving;
 final  String? actionErrorMessage;

/// Create a copy of RestrictedAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._installedApps, _installedApps)&&const DeepCollectionEquality().equals(other._savedRestrictedPackageNames, _savedRestrictedPackageNames)&&const DeepCollectionEquality().equals(other._draftRestrictedPackageNames, _draftRestrictedPackageNames)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_installedApps),const DeepCollectionEquality().hash(_savedRestrictedPackageNames),const DeepCollectionEquality().hash(_draftRestrictedPackageNames),isSaving,actionErrorMessage);

@override
String toString() {
  return 'RestrictedAppsSettingsState.loaded(installedApps: $installedApps, savedRestrictedPackageNames: $savedRestrictedPackageNames, draftRestrictedPackageNames: $draftRestrictedPackageNames, isSaving: $isSaving, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $RestrictedAppsSettingsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<LauncherApp> installedApps, Set<String> savedRestrictedPackageNames, Set<String> draftRestrictedPackageNames, bool isSaving, String? actionErrorMessage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of RestrictedAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? installedApps = null,Object? savedRestrictedPackageNames = null,Object? draftRestrictedPackageNames = null,Object? isSaving = null,Object? actionErrorMessage = freezed,}) {
  return _then(_Loaded(
installedApps: null == installedApps ? _self._installedApps : installedApps // ignore: cast_nullable_to_non_nullable
as List<LauncherApp>,savedRestrictedPackageNames: null == savedRestrictedPackageNames ? _self._savedRestrictedPackageNames : savedRestrictedPackageNames // ignore: cast_nullable_to_non_nullable
as Set<String>,draftRestrictedPackageNames: null == draftRestrictedPackageNames ? _self._draftRestrictedPackageNames : draftRestrictedPackageNames // ignore: cast_nullable_to_non_nullable
as Set<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Closing extends RestrictedAppsSettingsState {
  const _Closing({required final  Set<String> draftRestrictedPackageNames}): _draftRestrictedPackageNames = draftRestrictedPackageNames,super._();
  

 final  Set<String> _draftRestrictedPackageNames;
 Set<String> get draftRestrictedPackageNames {
  if (_draftRestrictedPackageNames is EqualUnmodifiableSetView) return _draftRestrictedPackageNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_draftRestrictedPackageNames);
}


/// Create a copy of RestrictedAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClosingCopyWith<_Closing> get copyWith => __$ClosingCopyWithImpl<_Closing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Closing&&const DeepCollectionEquality().equals(other._draftRestrictedPackageNames, _draftRestrictedPackageNames));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_draftRestrictedPackageNames));

@override
String toString() {
  return 'RestrictedAppsSettingsState.closing(draftRestrictedPackageNames: $draftRestrictedPackageNames)';
}


}

/// @nodoc
abstract mixin class _$ClosingCopyWith<$Res> implements $RestrictedAppsSettingsStateCopyWith<$Res> {
  factory _$ClosingCopyWith(_Closing value, $Res Function(_Closing) _then) = __$ClosingCopyWithImpl;
@useResult
$Res call({
 Set<String> draftRestrictedPackageNames
});




}
/// @nodoc
class __$ClosingCopyWithImpl<$Res>
    implements _$ClosingCopyWith<$Res> {
  __$ClosingCopyWithImpl(this._self, this._then);

  final _Closing _self;
  final $Res Function(_Closing) _then;

/// Create a copy of RestrictedAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftRestrictedPackageNames = null,}) {
  return _then(_Closing(
draftRestrictedPackageNames: null == draftRestrictedPackageNames ? _self._draftRestrictedPackageNames : draftRestrictedPackageNames // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class _Error extends RestrictedAppsSettingsState {
  const _Error({required this.message}): super._();
  

 final  String message;

/// Create a copy of RestrictedAppsSettingsState
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
  return 'RestrictedAppsSettingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RestrictedAppsSettingsStateCopyWith<$Res> {
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

/// Create a copy of RestrictedAppsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

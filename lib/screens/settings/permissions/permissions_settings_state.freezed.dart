// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PermissionsSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionsSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PermissionsSettingsState()';
}


}

/// @nodoc
class $PermissionsSettingsStateCopyWith<$Res>  {
$PermissionsSettingsStateCopyWith(PermissionsSettingsState _, $Res Function(PermissionsSettingsState) __);
}


/// Adds pattern-matching-related methods to [PermissionsSettingsState].
extension PermissionsSettingsStatePatterns on PermissionsSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loaded value)?  loaded,TResult Function( _Closing value)?  closing,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loaded value)  loaded,required TResult Function( _Closing value)  closing,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loaded value)?  loaded,TResult? Function( _Closing value)?  closing,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isOpening,  String? actionErrorMessage)?  loaded,TResult Function()?  closing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loaded() when loaded != null:
return loaded(_that.isOpening,_that.actionErrorMessage);case _Closing() when closing != null:
return closing();case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isOpening,  String? actionErrorMessage)  loaded,required TResult Function()  closing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loaded():
return loaded(_that.isOpening,_that.actionErrorMessage);case _Closing():
return closing();case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isOpening,  String? actionErrorMessage)?  loaded,TResult? Function()?  closing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loaded() when loaded != null:
return loaded(_that.isOpening,_that.actionErrorMessage);case _Closing() when closing != null:
return closing();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loaded implements PermissionsSettingsState {
  const _Loaded({this.isOpening = false, this.actionErrorMessage});
  

@JsonKey() final  bool isOpening;
 final  String? actionErrorMessage;

/// Create a copy of PermissionsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.isOpening, isOpening) || other.isOpening == isOpening)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isOpening,actionErrorMessage);

@override
String toString() {
  return 'PermissionsSettingsState.loaded(isOpening: $isOpening, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $PermissionsSettingsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 bool isOpening, String? actionErrorMessage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of PermissionsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isOpening = null,Object? actionErrorMessage = freezed,}) {
  return _then(_Loaded(
isOpening: null == isOpening ? _self.isOpening : isOpening // ignore: cast_nullable_to_non_nullable
as bool,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Closing implements PermissionsSettingsState {
  const _Closing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Closing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PermissionsSettingsState.closing()';
}


}




/// @nodoc


class _Error implements PermissionsSettingsState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of PermissionsSettingsState
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
  return 'PermissionsSettingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PermissionsSettingsStateCopyWith<$Res> {
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

/// Create a copy of PermissionsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

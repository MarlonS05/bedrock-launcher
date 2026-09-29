// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppearanceSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsState()';
}


}

/// @nodoc
class $AppearanceSettingsStateCopyWith<$Res>  {
$AppearanceSettingsStateCopyWith(AppearanceSettingsState _, $Res Function(AppearanceSettingsState) __);
}


/// Adds pattern-matching-related methods to [AppearanceSettingsState].
extension AppearanceSettingsStatePatterns on AppearanceSettingsState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int savedThemeColorArgb,  LauncherTextColor savedTextColor,  bool savedShowTileSeparators,  LauncherAppFont savedAppFont,  int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont,  List<LauncherAppFont> availableFonts,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult Function( int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont)?  closing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.savedThemeColorArgb,_that.savedTextColor,_that.savedShowTileSeparators,_that.savedAppFont,_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont,_that.availableFonts,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int savedThemeColorArgb,  LauncherTextColor savedTextColor,  bool savedShowTileSeparators,  LauncherAppFont savedAppFont,  int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont,  List<LauncherAppFont> availableFonts,  bool isSaving,  String? actionErrorMessage)  loaded,required TResult Function( int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont)  closing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.savedThemeColorArgb,_that.savedTextColor,_that.savedShowTileSeparators,_that.savedAppFont,_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont,_that.availableFonts,_that.isSaving,_that.actionErrorMessage);case _Closing():
return closing(_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int savedThemeColorArgb,  LauncherTextColor savedTextColor,  bool savedShowTileSeparators,  LauncherAppFont savedAppFont,  int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont,  List<LauncherAppFont> availableFonts,  bool isSaving,  String? actionErrorMessage)?  loaded,TResult? Function( int draftThemeColorArgb,  LauncherTextColor draftTextColor,  bool draftShowTileSeparators,  LauncherAppFont draftAppFont)?  closing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.savedThemeColorArgb,_that.savedTextColor,_that.savedShowTileSeparators,_that.savedAppFont,_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont,_that.availableFonts,_that.isSaving,_that.actionErrorMessage);case _Closing() when closing != null:
return closing(_that.draftThemeColorArgb,_that.draftTextColor,_that.draftShowTileSeparators,_that.draftAppFont);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loading extends AppearanceSettingsState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsState.loading()';
}


}




/// @nodoc


class _Loaded extends AppearanceSettingsState {
  const _Loaded({required this.savedThemeColorArgb, required this.savedTextColor, required this.savedShowTileSeparators, required this.savedAppFont, required this.draftThemeColorArgb, required this.draftTextColor, required this.draftShowTileSeparators, required this.draftAppFont, final  List<LauncherAppFont> availableFonts = const <LauncherAppFont>[LauncherAppFont.system], this.isSaving = false, this.actionErrorMessage}): _availableFonts = availableFonts,super._();
  

 final  int savedThemeColorArgb;
 final  LauncherTextColor savedTextColor;
 final  bool savedShowTileSeparators;
 final  LauncherAppFont savedAppFont;
 final  int draftThemeColorArgb;
 final  LauncherTextColor draftTextColor;
 final  bool draftShowTileSeparators;
 final  LauncherAppFont draftAppFont;
 final  List<LauncherAppFont> _availableFonts;
@JsonKey() List<LauncherAppFont> get availableFonts {
  if (_availableFonts is EqualUnmodifiableListView) return _availableFonts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableFonts);
}

@JsonKey() final  bool isSaving;
 final  String? actionErrorMessage;

/// Create a copy of AppearanceSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.savedThemeColorArgb, savedThemeColorArgb) || other.savedThemeColorArgb == savedThemeColorArgb)&&(identical(other.savedTextColor, savedTextColor) || other.savedTextColor == savedTextColor)&&(identical(other.savedShowTileSeparators, savedShowTileSeparators) || other.savedShowTileSeparators == savedShowTileSeparators)&&(identical(other.savedAppFont, savedAppFont) || other.savedAppFont == savedAppFont)&&(identical(other.draftThemeColorArgb, draftThemeColorArgb) || other.draftThemeColorArgb == draftThemeColorArgb)&&(identical(other.draftTextColor, draftTextColor) || other.draftTextColor == draftTextColor)&&(identical(other.draftShowTileSeparators, draftShowTileSeparators) || other.draftShowTileSeparators == draftShowTileSeparators)&&(identical(other.draftAppFont, draftAppFont) || other.draftAppFont == draftAppFont)&&const DeepCollectionEquality().equals(other._availableFonts, _availableFonts)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.actionErrorMessage, actionErrorMessage) || other.actionErrorMessage == actionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,savedThemeColorArgb,savedTextColor,savedShowTileSeparators,savedAppFont,draftThemeColorArgb,draftTextColor,draftShowTileSeparators,draftAppFont,const DeepCollectionEquality().hash(_availableFonts),isSaving,actionErrorMessage);

@override
String toString() {
  return 'AppearanceSettingsState.loaded(savedThemeColorArgb: $savedThemeColorArgb, savedTextColor: $savedTextColor, savedShowTileSeparators: $savedShowTileSeparators, savedAppFont: $savedAppFont, draftThemeColorArgb: $draftThemeColorArgb, draftTextColor: $draftTextColor, draftShowTileSeparators: $draftShowTileSeparators, draftAppFont: $draftAppFont, availableFonts: $availableFonts, isSaving: $isSaving, actionErrorMessage: $actionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AppearanceSettingsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 int savedThemeColorArgb, LauncherTextColor savedTextColor, bool savedShowTileSeparators, LauncherAppFont savedAppFont, int draftThemeColorArgb, LauncherTextColor draftTextColor, bool draftShowTileSeparators, LauncherAppFont draftAppFont, List<LauncherAppFont> availableFonts, bool isSaving, String? actionErrorMessage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AppearanceSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? savedThemeColorArgb = null,Object? savedTextColor = null,Object? savedShowTileSeparators = null,Object? savedAppFont = null,Object? draftThemeColorArgb = null,Object? draftTextColor = null,Object? draftShowTileSeparators = null,Object? draftAppFont = null,Object? availableFonts = null,Object? isSaving = null,Object? actionErrorMessage = freezed,}) {
  return _then(_Loaded(
savedThemeColorArgb: null == savedThemeColorArgb ? _self.savedThemeColorArgb : savedThemeColorArgb // ignore: cast_nullable_to_non_nullable
as int,savedTextColor: null == savedTextColor ? _self.savedTextColor : savedTextColor // ignore: cast_nullable_to_non_nullable
as LauncherTextColor,savedShowTileSeparators: null == savedShowTileSeparators ? _self.savedShowTileSeparators : savedShowTileSeparators // ignore: cast_nullable_to_non_nullable
as bool,savedAppFont: null == savedAppFont ? _self.savedAppFont : savedAppFont // ignore: cast_nullable_to_non_nullable
as LauncherAppFont,draftThemeColorArgb: null == draftThemeColorArgb ? _self.draftThemeColorArgb : draftThemeColorArgb // ignore: cast_nullable_to_non_nullable
as int,draftTextColor: null == draftTextColor ? _self.draftTextColor : draftTextColor // ignore: cast_nullable_to_non_nullable
as LauncherTextColor,draftShowTileSeparators: null == draftShowTileSeparators ? _self.draftShowTileSeparators : draftShowTileSeparators // ignore: cast_nullable_to_non_nullable
as bool,draftAppFont: null == draftAppFont ? _self.draftAppFont : draftAppFont // ignore: cast_nullable_to_non_nullable
as LauncherAppFont,availableFonts: null == availableFonts ? _self._availableFonts : availableFonts // ignore: cast_nullable_to_non_nullable
as List<LauncherAppFont>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,actionErrorMessage: freezed == actionErrorMessage ? _self.actionErrorMessage : actionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Closing extends AppearanceSettingsState {
  const _Closing({required this.draftThemeColorArgb, required this.draftTextColor, required this.draftShowTileSeparators, required this.draftAppFont}): super._();
  

 final  int draftThemeColorArgb;
 final  LauncherTextColor draftTextColor;
 final  bool draftShowTileSeparators;
 final  LauncherAppFont draftAppFont;

/// Create a copy of AppearanceSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClosingCopyWith<_Closing> get copyWith => __$ClosingCopyWithImpl<_Closing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Closing&&(identical(other.draftThemeColorArgb, draftThemeColorArgb) || other.draftThemeColorArgb == draftThemeColorArgb)&&(identical(other.draftTextColor, draftTextColor) || other.draftTextColor == draftTextColor)&&(identical(other.draftShowTileSeparators, draftShowTileSeparators) || other.draftShowTileSeparators == draftShowTileSeparators)&&(identical(other.draftAppFont, draftAppFont) || other.draftAppFont == draftAppFont));
}


@override
int get hashCode => Object.hash(runtimeType,draftThemeColorArgb,draftTextColor,draftShowTileSeparators,draftAppFont);

@override
String toString() {
  return 'AppearanceSettingsState.closing(draftThemeColorArgb: $draftThemeColorArgb, draftTextColor: $draftTextColor, draftShowTileSeparators: $draftShowTileSeparators, draftAppFont: $draftAppFont)';
}


}

/// @nodoc
abstract mixin class _$ClosingCopyWith<$Res> implements $AppearanceSettingsStateCopyWith<$Res> {
  factory _$ClosingCopyWith(_Closing value, $Res Function(_Closing) _then) = __$ClosingCopyWithImpl;
@useResult
$Res call({
 int draftThemeColorArgb, LauncherTextColor draftTextColor, bool draftShowTileSeparators, LauncherAppFont draftAppFont
});




}
/// @nodoc
class __$ClosingCopyWithImpl<$Res>
    implements _$ClosingCopyWith<$Res> {
  __$ClosingCopyWithImpl(this._self, this._then);

  final _Closing _self;
  final $Res Function(_Closing) _then;

/// Create a copy of AppearanceSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftThemeColorArgb = null,Object? draftTextColor = null,Object? draftShowTileSeparators = null,Object? draftAppFont = null,}) {
  return _then(_Closing(
draftThemeColorArgb: null == draftThemeColorArgb ? _self.draftThemeColorArgb : draftThemeColorArgb // ignore: cast_nullable_to_non_nullable
as int,draftTextColor: null == draftTextColor ? _self.draftTextColor : draftTextColor // ignore: cast_nullable_to_non_nullable
as LauncherTextColor,draftShowTileSeparators: null == draftShowTileSeparators ? _self.draftShowTileSeparators : draftShowTileSeparators // ignore: cast_nullable_to_non_nullable
as bool,draftAppFont: null == draftAppFont ? _self.draftAppFont : draftAppFont // ignore: cast_nullable_to_non_nullable
as LauncherAppFont,
  ));
}


}

/// @nodoc


class _Error extends AppearanceSettingsState {
  const _Error({required this.message}): super._();
  

 final  String message;

/// Create a copy of AppearanceSettingsState
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
  return 'AppearanceSettingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AppearanceSettingsStateCopyWith<$Res> {
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

/// Create a copy of AppearanceSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

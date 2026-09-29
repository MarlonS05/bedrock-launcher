// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppearanceSettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsEvent()';
}


}

/// @nodoc
class $AppearanceSettingsEventCopyWith<$Res>  {
$AppearanceSettingsEventCopyWith(AppearanceSettingsEvent _, $Res Function(AppearanceSettingsEvent) __);
}


/// Adds pattern-matching-related methods to [AppearanceSettingsEvent].
extension AppearanceSettingsEventPatterns on AppearanceSettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BackTapped value)?  backTapped,TResult Function( _SaveTapped value)?  saveTapped,TResult Function( _ThemeColorChanged value)?  themeColorChanged,TResult Function( _TextColorChanged value)?  textColorChanged,TResult Function( _TileSeparatorsChanged value)?  tileSeparatorsChanged,TResult Function( _AppFontChanged value)?  appFontChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _ThemeColorChanged() when themeColorChanged != null:
return themeColorChanged(_that);case _TextColorChanged() when textColorChanged != null:
return textColorChanged(_that);case _TileSeparatorsChanged() when tileSeparatorsChanged != null:
return tileSeparatorsChanged(_that);case _AppFontChanged() when appFontChanged != null:
return appFontChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BackTapped value)  backTapped,required TResult Function( _SaveTapped value)  saveTapped,required TResult Function( _ThemeColorChanged value)  themeColorChanged,required TResult Function( _TextColorChanged value)  textColorChanged,required TResult Function( _TileSeparatorsChanged value)  tileSeparatorsChanged,required TResult Function( _AppFontChanged value)  appFontChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BackTapped():
return backTapped(_that);case _SaveTapped():
return saveTapped(_that);case _ThemeColorChanged():
return themeColorChanged(_that);case _TextColorChanged():
return textColorChanged(_that);case _TileSeparatorsChanged():
return tileSeparatorsChanged(_that);case _AppFontChanged():
return appFontChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BackTapped value)?  backTapped,TResult? Function( _SaveTapped value)?  saveTapped,TResult? Function( _ThemeColorChanged value)?  themeColorChanged,TResult? Function( _TextColorChanged value)?  textColorChanged,TResult? Function( _TileSeparatorsChanged value)?  tileSeparatorsChanged,TResult? Function( _AppFontChanged value)?  appFontChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _ThemeColorChanged() when themeColorChanged != null:
return themeColorChanged(_that);case _TextColorChanged() when textColorChanged != null:
return textColorChanged(_that);case _TileSeparatorsChanged() when tileSeparatorsChanged != null:
return tileSeparatorsChanged(_that);case _AppFontChanged() when appFontChanged != null:
return appFontChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  backTapped,TResult Function()?  saveTapped,TResult Function( int colorArgb)?  themeColorChanged,TResult Function( LauncherTextColor textColor)?  textColorChanged,TResult Function( bool show)?  tileSeparatorsChanged,TResult Function( LauncherAppFont appFont)?  appFontChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _ThemeColorChanged() when themeColorChanged != null:
return themeColorChanged(_that.colorArgb);case _TextColorChanged() when textColorChanged != null:
return textColorChanged(_that.textColor);case _TileSeparatorsChanged() when tileSeparatorsChanged != null:
return tileSeparatorsChanged(_that.show);case _AppFontChanged() when appFontChanged != null:
return appFontChanged(_that.appFont);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  backTapped,required TResult Function()  saveTapped,required TResult Function( int colorArgb)  themeColorChanged,required TResult Function( LauncherTextColor textColor)  textColorChanged,required TResult Function( bool show)  tileSeparatorsChanged,required TResult Function( LauncherAppFont appFont)  appFontChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BackTapped():
return backTapped();case _SaveTapped():
return saveTapped();case _ThemeColorChanged():
return themeColorChanged(_that.colorArgb);case _TextColorChanged():
return textColorChanged(_that.textColor);case _TileSeparatorsChanged():
return tileSeparatorsChanged(_that.show);case _AppFontChanged():
return appFontChanged(_that.appFont);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  backTapped,TResult? Function()?  saveTapped,TResult? Function( int colorArgb)?  themeColorChanged,TResult? Function( LauncherTextColor textColor)?  textColorChanged,TResult? Function( bool show)?  tileSeparatorsChanged,TResult? Function( LauncherAppFont appFont)?  appFontChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _ThemeColorChanged() when themeColorChanged != null:
return themeColorChanged(_that.colorArgb);case _TextColorChanged() when textColorChanged != null:
return textColorChanged(_that.textColor);case _TileSeparatorsChanged() when tileSeparatorsChanged != null:
return tileSeparatorsChanged(_that.show);case _AppFontChanged() when appFontChanged != null:
return appFontChanged(_that.appFont);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AppearanceSettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsEvent.started()';
}


}




/// @nodoc


class _BackTapped implements AppearanceSettingsEvent {
  const _BackTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsEvent.backTapped()';
}


}




/// @nodoc


class _SaveTapped implements AppearanceSettingsEvent {
  const _SaveTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppearanceSettingsEvent.saveTapped()';
}


}




/// @nodoc


class _ThemeColorChanged implements AppearanceSettingsEvent {
  const _ThemeColorChanged(this.colorArgb);
  

 final  int colorArgb;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeColorChangedCopyWith<_ThemeColorChanged> get copyWith => __$ThemeColorChangedCopyWithImpl<_ThemeColorChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeColorChanged&&(identical(other.colorArgb, colorArgb) || other.colorArgb == colorArgb));
}


@override
int get hashCode => Object.hash(runtimeType,colorArgb);

@override
String toString() {
  return 'AppearanceSettingsEvent.themeColorChanged(colorArgb: $colorArgb)';
}


}

/// @nodoc
abstract mixin class _$ThemeColorChangedCopyWith<$Res> implements $AppearanceSettingsEventCopyWith<$Res> {
  factory _$ThemeColorChangedCopyWith(_ThemeColorChanged value, $Res Function(_ThemeColorChanged) _then) = __$ThemeColorChangedCopyWithImpl;
@useResult
$Res call({
 int colorArgb
});




}
/// @nodoc
class __$ThemeColorChangedCopyWithImpl<$Res>
    implements _$ThemeColorChangedCopyWith<$Res> {
  __$ThemeColorChangedCopyWithImpl(this._self, this._then);

  final _ThemeColorChanged _self;
  final $Res Function(_ThemeColorChanged) _then;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? colorArgb = null,}) {
  return _then(_ThemeColorChanged(
null == colorArgb ? _self.colorArgb : colorArgb // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _TextColorChanged implements AppearanceSettingsEvent {
  const _TextColorChanged(this.textColor);
  

 final  LauncherTextColor textColor;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextColorChangedCopyWith<_TextColorChanged> get copyWith => __$TextColorChangedCopyWithImpl<_TextColorChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextColorChanged&&(identical(other.textColor, textColor) || other.textColor == textColor));
}


@override
int get hashCode => Object.hash(runtimeType,textColor);

@override
String toString() {
  return 'AppearanceSettingsEvent.textColorChanged(textColor: $textColor)';
}


}

/// @nodoc
abstract mixin class _$TextColorChangedCopyWith<$Res> implements $AppearanceSettingsEventCopyWith<$Res> {
  factory _$TextColorChangedCopyWith(_TextColorChanged value, $Res Function(_TextColorChanged) _then) = __$TextColorChangedCopyWithImpl;
@useResult
$Res call({
 LauncherTextColor textColor
});




}
/// @nodoc
class __$TextColorChangedCopyWithImpl<$Res>
    implements _$TextColorChangedCopyWith<$Res> {
  __$TextColorChangedCopyWithImpl(this._self, this._then);

  final _TextColorChanged _self;
  final $Res Function(_TextColorChanged) _then;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textColor = null,}) {
  return _then(_TextColorChanged(
null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as LauncherTextColor,
  ));
}


}

/// @nodoc


class _TileSeparatorsChanged implements AppearanceSettingsEvent {
  const _TileSeparatorsChanged(this.show);
  

 final  bool show;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TileSeparatorsChangedCopyWith<_TileSeparatorsChanged> get copyWith => __$TileSeparatorsChangedCopyWithImpl<_TileSeparatorsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TileSeparatorsChanged&&(identical(other.show, show) || other.show == show));
}


@override
int get hashCode => Object.hash(runtimeType,show);

@override
String toString() {
  return 'AppearanceSettingsEvent.tileSeparatorsChanged(show: $show)';
}


}

/// @nodoc
abstract mixin class _$TileSeparatorsChangedCopyWith<$Res> implements $AppearanceSettingsEventCopyWith<$Res> {
  factory _$TileSeparatorsChangedCopyWith(_TileSeparatorsChanged value, $Res Function(_TileSeparatorsChanged) _then) = __$TileSeparatorsChangedCopyWithImpl;
@useResult
$Res call({
 bool show
});




}
/// @nodoc
class __$TileSeparatorsChangedCopyWithImpl<$Res>
    implements _$TileSeparatorsChangedCopyWith<$Res> {
  __$TileSeparatorsChangedCopyWithImpl(this._self, this._then);

  final _TileSeparatorsChanged _self;
  final $Res Function(_TileSeparatorsChanged) _then;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? show = null,}) {
  return _then(_TileSeparatorsChanged(
null == show ? _self.show : show // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _AppFontChanged implements AppearanceSettingsEvent {
  const _AppFontChanged(this.appFont);
  

 final  LauncherAppFont appFont;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppFontChangedCopyWith<_AppFontChanged> get copyWith => __$AppFontChangedCopyWithImpl<_AppFontChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppFontChanged&&(identical(other.appFont, appFont) || other.appFont == appFont));
}


@override
int get hashCode => Object.hash(runtimeType,appFont);

@override
String toString() {
  return 'AppearanceSettingsEvent.appFontChanged(appFont: $appFont)';
}


}

/// @nodoc
abstract mixin class _$AppFontChangedCopyWith<$Res> implements $AppearanceSettingsEventCopyWith<$Res> {
  factory _$AppFontChangedCopyWith(_AppFontChanged value, $Res Function(_AppFontChanged) _then) = __$AppFontChangedCopyWithImpl;
@useResult
$Res call({
 LauncherAppFont appFont
});




}
/// @nodoc
class __$AppFontChangedCopyWithImpl<$Res>
    implements _$AppFontChangedCopyWith<$Res> {
  __$AppFontChangedCopyWithImpl(this._self, this._then);

  final _AppFontChanged _self;
  final $Res Function(_AppFontChanged) _then;

/// Create a copy of AppearanceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? appFont = null,}) {
  return _then(_AppFontChanged(
null == appFont ? _self.appFont : appFont // ignore: cast_nullable_to_non_nullable
as LauncherAppFont,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restricted_apps_settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestrictedAppsSettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestrictedAppsSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsEvent()';
}


}

/// @nodoc
class $RestrictedAppsSettingsEventCopyWith<$Res>  {
$RestrictedAppsSettingsEventCopyWith(RestrictedAppsSettingsEvent _, $Res Function(RestrictedAppsSettingsEvent) __);
}


/// Adds pattern-matching-related methods to [RestrictedAppsSettingsEvent].
extension RestrictedAppsSettingsEventPatterns on RestrictedAppsSettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BackTapped value)?  backTapped,TResult Function( _SaveTapped value)?  saveTapped,TResult Function( _RestrictedAppToggled value)?  restrictedAppToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _RestrictedAppToggled() when restrictedAppToggled != null:
return restrictedAppToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BackTapped value)  backTapped,required TResult Function( _SaveTapped value)  saveTapped,required TResult Function( _RestrictedAppToggled value)  restrictedAppToggled,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BackTapped():
return backTapped(_that);case _SaveTapped():
return saveTapped(_that);case _RestrictedAppToggled():
return restrictedAppToggled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BackTapped value)?  backTapped,TResult? Function( _SaveTapped value)?  saveTapped,TResult? Function( _RestrictedAppToggled value)?  restrictedAppToggled,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _RestrictedAppToggled() when restrictedAppToggled != null:
return restrictedAppToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  backTapped,TResult Function()?  saveTapped,TResult Function( String packageName)?  restrictedAppToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _RestrictedAppToggled() when restrictedAppToggled != null:
return restrictedAppToggled(_that.packageName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  backTapped,required TResult Function()  saveTapped,required TResult Function( String packageName)  restrictedAppToggled,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BackTapped():
return backTapped();case _SaveTapped():
return saveTapped();case _RestrictedAppToggled():
return restrictedAppToggled(_that.packageName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  backTapped,TResult? Function()?  saveTapped,TResult? Function( String packageName)?  restrictedAppToggled,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _RestrictedAppToggled() when restrictedAppToggled != null:
return restrictedAppToggled(_that.packageName);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements RestrictedAppsSettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsEvent.started()';
}


}




/// @nodoc


class _BackTapped implements RestrictedAppsSettingsEvent {
  const _BackTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsEvent.backTapped()';
}


}




/// @nodoc


class _SaveTapped implements RestrictedAppsSettingsEvent {
  const _SaveTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RestrictedAppsSettingsEvent.saveTapped()';
}


}




/// @nodoc


class _RestrictedAppToggled implements RestrictedAppsSettingsEvent {
  const _RestrictedAppToggled(this.packageName);
  

 final  String packageName;

/// Create a copy of RestrictedAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestrictedAppToggledCopyWith<_RestrictedAppToggled> get copyWith => __$RestrictedAppToggledCopyWithImpl<_RestrictedAppToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedAppToggled&&(identical(other.packageName, packageName) || other.packageName == packageName));
}


@override
int get hashCode => Object.hash(runtimeType,packageName);

@override
String toString() {
  return 'RestrictedAppsSettingsEvent.restrictedAppToggled(packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$RestrictedAppToggledCopyWith<$Res> implements $RestrictedAppsSettingsEventCopyWith<$Res> {
  factory _$RestrictedAppToggledCopyWith(_RestrictedAppToggled value, $Res Function(_RestrictedAppToggled) _then) = __$RestrictedAppToggledCopyWithImpl;
@useResult
$Res call({
 String packageName
});




}
/// @nodoc
class __$RestrictedAppToggledCopyWithImpl<$Res>
    implements _$RestrictedAppToggledCopyWith<$Res> {
  __$RestrictedAppToggledCopyWithImpl(this._self, this._then);

  final _RestrictedAppToggled _self;
  final $Res Function(_RestrictedAppToggled) _then;

/// Create a copy of RestrictedAppsSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageName = null,}) {
  return _then(_RestrictedAppToggled(
null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BackTapped value)?  backTapped,TResult Function( _AppearanceTapped value)?  appearanceTapped,TResult Function( _PermissionsTapped value)?  permissionsTapped,TResult Function( _FavoritesTapped value)?  favoritesTapped,TResult Function( _PreferredAppsTapped value)?  preferredAppsTapped,TResult Function( _RestrictedAppsTapped value)?  restrictedAppsTapped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _AppearanceTapped() when appearanceTapped != null:
return appearanceTapped(_that);case _PermissionsTapped() when permissionsTapped != null:
return permissionsTapped(_that);case _FavoritesTapped() when favoritesTapped != null:
return favoritesTapped(_that);case _PreferredAppsTapped() when preferredAppsTapped != null:
return preferredAppsTapped(_that);case _RestrictedAppsTapped() when restrictedAppsTapped != null:
return restrictedAppsTapped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BackTapped value)  backTapped,required TResult Function( _AppearanceTapped value)  appearanceTapped,required TResult Function( _PermissionsTapped value)  permissionsTapped,required TResult Function( _FavoritesTapped value)  favoritesTapped,required TResult Function( _PreferredAppsTapped value)  preferredAppsTapped,required TResult Function( _RestrictedAppsTapped value)  restrictedAppsTapped,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BackTapped():
return backTapped(_that);case _AppearanceTapped():
return appearanceTapped(_that);case _PermissionsTapped():
return permissionsTapped(_that);case _FavoritesTapped():
return favoritesTapped(_that);case _PreferredAppsTapped():
return preferredAppsTapped(_that);case _RestrictedAppsTapped():
return restrictedAppsTapped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BackTapped value)?  backTapped,TResult? Function( _AppearanceTapped value)?  appearanceTapped,TResult? Function( _PermissionsTapped value)?  permissionsTapped,TResult? Function( _FavoritesTapped value)?  favoritesTapped,TResult? Function( _PreferredAppsTapped value)?  preferredAppsTapped,TResult? Function( _RestrictedAppsTapped value)?  restrictedAppsTapped,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _AppearanceTapped() when appearanceTapped != null:
return appearanceTapped(_that);case _PermissionsTapped() when permissionsTapped != null:
return permissionsTapped(_that);case _FavoritesTapped() when favoritesTapped != null:
return favoritesTapped(_that);case _PreferredAppsTapped() when preferredAppsTapped != null:
return preferredAppsTapped(_that);case _RestrictedAppsTapped() when restrictedAppsTapped != null:
return restrictedAppsTapped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  backTapped,TResult Function()?  appearanceTapped,TResult Function()?  permissionsTapped,TResult Function()?  favoritesTapped,TResult Function()?  preferredAppsTapped,TResult Function()?  restrictedAppsTapped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _AppearanceTapped() when appearanceTapped != null:
return appearanceTapped();case _PermissionsTapped() when permissionsTapped != null:
return permissionsTapped();case _FavoritesTapped() when favoritesTapped != null:
return favoritesTapped();case _PreferredAppsTapped() when preferredAppsTapped != null:
return preferredAppsTapped();case _RestrictedAppsTapped() when restrictedAppsTapped != null:
return restrictedAppsTapped();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  backTapped,required TResult Function()  appearanceTapped,required TResult Function()  permissionsTapped,required TResult Function()  favoritesTapped,required TResult Function()  preferredAppsTapped,required TResult Function()  restrictedAppsTapped,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BackTapped():
return backTapped();case _AppearanceTapped():
return appearanceTapped();case _PermissionsTapped():
return permissionsTapped();case _FavoritesTapped():
return favoritesTapped();case _PreferredAppsTapped():
return preferredAppsTapped();case _RestrictedAppsTapped():
return restrictedAppsTapped();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  backTapped,TResult? Function()?  appearanceTapped,TResult? Function()?  permissionsTapped,TResult? Function()?  favoritesTapped,TResult? Function()?  preferredAppsTapped,TResult? Function()?  restrictedAppsTapped,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _AppearanceTapped() when appearanceTapped != null:
return appearanceTapped();case _PermissionsTapped() when permissionsTapped != null:
return permissionsTapped();case _FavoritesTapped() when favoritesTapped != null:
return favoritesTapped();case _PreferredAppsTapped() when preferredAppsTapped != null:
return preferredAppsTapped();case _RestrictedAppsTapped() when restrictedAppsTapped != null:
return restrictedAppsTapped();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class _BackTapped implements SettingsEvent {
  const _BackTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.backTapped()';
}


}




/// @nodoc


class _AppearanceTapped implements SettingsEvent {
  const _AppearanceTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppearanceTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.appearanceTapped()';
}


}




/// @nodoc


class _PermissionsTapped implements SettingsEvent {
  const _PermissionsTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionsTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.permissionsTapped()';
}


}




/// @nodoc


class _FavoritesTapped implements SettingsEvent {
  const _FavoritesTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.favoritesTapped()';
}


}




/// @nodoc


class _PreferredAppsTapped implements SettingsEvent {
  const _PreferredAppsTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreferredAppsTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.preferredAppsTapped()';
}


}




/// @nodoc


class _RestrictedAppsTapped implements SettingsEvent {
  const _RestrictedAppsTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedAppsTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.restrictedAppsTapped()';
}


}




// dart format on

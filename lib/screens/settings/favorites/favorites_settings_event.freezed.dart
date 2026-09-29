// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesSettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesSettingsEvent()';
}


}

/// @nodoc
class $FavoritesSettingsEventCopyWith<$Res>  {
$FavoritesSettingsEventCopyWith(FavoritesSettingsEvent _, $Res Function(FavoritesSettingsEvent) __);
}


/// Adds pattern-matching-related methods to [FavoritesSettingsEvent].
extension FavoritesSettingsEventPatterns on FavoritesSettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BackTapped value)?  backTapped,TResult Function( _SaveTapped value)?  saveTapped,TResult Function( _OrderChanged value)?  orderChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _OrderChanged() when orderChanged != null:
return orderChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BackTapped value)  backTapped,required TResult Function( _SaveTapped value)  saveTapped,required TResult Function( _OrderChanged value)  orderChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BackTapped():
return backTapped(_that);case _SaveTapped():
return saveTapped(_that);case _OrderChanged():
return orderChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BackTapped value)?  backTapped,TResult? Function( _SaveTapped value)?  saveTapped,TResult? Function( _OrderChanged value)?  orderChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BackTapped() when backTapped != null:
return backTapped(_that);case _SaveTapped() when saveTapped != null:
return saveTapped(_that);case _OrderChanged() when orderChanged != null:
return orderChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  backTapped,TResult Function()?  saveTapped,TResult Function( List<String> packageNamesInOrder)?  orderChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _OrderChanged() when orderChanged != null:
return orderChanged(_that.packageNamesInOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  backTapped,required TResult Function()  saveTapped,required TResult Function( List<String> packageNamesInOrder)  orderChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BackTapped():
return backTapped();case _SaveTapped():
return saveTapped();case _OrderChanged():
return orderChanged(_that.packageNamesInOrder);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  backTapped,TResult? Function()?  saveTapped,TResult? Function( List<String> packageNamesInOrder)?  orderChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BackTapped() when backTapped != null:
return backTapped();case _SaveTapped() when saveTapped != null:
return saveTapped();case _OrderChanged() when orderChanged != null:
return orderChanged(_that.packageNamesInOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements FavoritesSettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesSettingsEvent.started()';
}


}




/// @nodoc


class _BackTapped implements FavoritesSettingsEvent {
  const _BackTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesSettingsEvent.backTapped()';
}


}




/// @nodoc


class _SaveTapped implements FavoritesSettingsEvent {
  const _SaveTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesSettingsEvent.saveTapped()';
}


}




/// @nodoc


class _OrderChanged implements FavoritesSettingsEvent {
  const _OrderChanged(final  List<String> packageNamesInOrder): _packageNamesInOrder = packageNamesInOrder;
  

 final  List<String> _packageNamesInOrder;
 List<String> get packageNamesInOrder {
  if (_packageNamesInOrder is EqualUnmodifiableListView) return _packageNamesInOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packageNamesInOrder);
}


/// Create a copy of FavoritesSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderChangedCopyWith<_OrderChanged> get copyWith => __$OrderChangedCopyWithImpl<_OrderChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderChanged&&const DeepCollectionEquality().equals(other._packageNamesInOrder, _packageNamesInOrder));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_packageNamesInOrder));

@override
String toString() {
  return 'FavoritesSettingsEvent.orderChanged(packageNamesInOrder: $packageNamesInOrder)';
}


}

/// @nodoc
abstract mixin class _$OrderChangedCopyWith<$Res> implements $FavoritesSettingsEventCopyWith<$Res> {
  factory _$OrderChangedCopyWith(_OrderChanged value, $Res Function(_OrderChanged) _then) = __$OrderChangedCopyWithImpl;
@useResult
$Res call({
 List<String> packageNamesInOrder
});




}
/// @nodoc
class __$OrderChangedCopyWithImpl<$Res>
    implements _$OrderChangedCopyWith<$Res> {
  __$OrderChangedCopyWithImpl(this._self, this._then);

  final _OrderChanged _self;
  final $Res Function(_OrderChanged) _then;

/// Create a copy of FavoritesSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? packageNamesInOrder = null,}) {
  return _then(_OrderChanged(
null == packageNamesInOrder ? _self._packageNamesInOrder : packageNamesInOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

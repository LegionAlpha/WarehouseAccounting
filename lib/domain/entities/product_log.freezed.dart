// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductLog {

 int get id; String get productId; int get userId; String get userName; LogAction get action; DateTime get timestamp;
/// Create a copy of ProductLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductLogCopyWith<ProductLog> get copyWith => _$ProductLogCopyWithImpl<ProductLog>(this as ProductLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLog&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.action, action) || other.action == action)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,userId,userName,action,timestamp);

@override
String toString() {
  return 'ProductLog(id: $id, productId: $productId, userId: $userId, userName: $userName, action: $action, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ProductLogCopyWith<$Res>  {
  factory $ProductLogCopyWith(ProductLog value, $Res Function(ProductLog) _then) = _$ProductLogCopyWithImpl;
@useResult
$Res call({
 int id, String productId, int userId, String userName, LogAction action, DateTime timestamp
});




}
/// @nodoc
class _$ProductLogCopyWithImpl<$Res>
    implements $ProductLogCopyWith<$Res> {
  _$ProductLogCopyWithImpl(this._self, this._then);

  final ProductLog _self;
  final $Res Function(ProductLog) _then;

/// Create a copy of ProductLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? userId = null,Object? userName = null,Object? action = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LogAction,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductLog].
extension ProductLogPatterns on ProductLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductLog() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductLog value)  $default,){
final _that = this;
switch (_that) {
case _ProductLog():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductLog value)?  $default,){
final _that = this;
switch (_that) {
case _ProductLog() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String productId,  int userId,  String userName,  LogAction action,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductLog() when $default != null:
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.action,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String productId,  int userId,  String userName,  LogAction action,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ProductLog():
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.action,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String productId,  int userId,  String userName,  LogAction action,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ProductLog() when $default != null:
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.action,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _ProductLog implements ProductLog {
  const _ProductLog({required this.id, required this.productId, required this.userId, required this.userName, required this.action, required this.timestamp});
  

@override final  int id;
@override final  String productId;
@override final  int userId;
@override final  String userName;
@override final  LogAction action;
@override final  DateTime timestamp;

/// Create a copy of ProductLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductLogCopyWith<_ProductLog> get copyWith => __$ProductLogCopyWithImpl<_ProductLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductLog&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.action, action) || other.action == action)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,userId,userName,action,timestamp);

@override
String toString() {
  return 'ProductLog(id: $id, productId: $productId, userId: $userId, userName: $userName, action: $action, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ProductLogCopyWith<$Res> implements $ProductLogCopyWith<$Res> {
  factory _$ProductLogCopyWith(_ProductLog value, $Res Function(_ProductLog) _then) = __$ProductLogCopyWithImpl;
@override @useResult
$Res call({
 int id, String productId, int userId, String userName, LogAction action, DateTime timestamp
});




}
/// @nodoc
class __$ProductLogCopyWithImpl<$Res>
    implements _$ProductLogCopyWith<$Res> {
  __$ProductLogCopyWithImpl(this._self, this._then);

  final _ProductLog _self;
  final $Res Function(_ProductLog) _then;

/// Create a copy of ProductLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? userId = null,Object? userName = null,Object? action = null,Object? timestamp = null,}) {
  return _then(_ProductLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LogAction,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

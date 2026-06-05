// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 String get id; String get name; String get description; ProductStatus get status; int get createdBy; DateTime get createdAt; String? get imagePath; int? get takenByUserId; String? get takenByName; DateTime? get takenAt;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.takenByUserId, takenByUserId) || other.takenByUserId == takenByUserId)&&(identical(other.takenByName, takenByName) || other.takenByName == takenByName)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,status,createdBy,createdAt,imagePath,takenByUserId,takenByName,takenAt);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, status: $status, createdBy: $createdBy, createdAt: $createdAt, imagePath: $imagePath, takenByUserId: $takenByUserId, takenByName: $takenByName, takenAt: $takenAt)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, ProductStatus status, int createdBy, DateTime createdAt, String? imagePath, int? takenByUserId, String? takenByName, DateTime? takenAt
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? status = null,Object? createdBy = null,Object? createdAt = null,Object? imagePath = freezed,Object? takenByUserId = freezed,Object? takenByName = freezed,Object? takenAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductStatus,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,takenByUserId: freezed == takenByUserId ? _self.takenByUserId : takenByUserId // ignore: cast_nullable_to_non_nullable
as int?,takenByName: freezed == takenByName ? _self.takenByName : takenByName // ignore: cast_nullable_to_non_nullable
as String?,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  ProductStatus status,  int createdBy,  DateTime createdAt,  String? imagePath,  int? takenByUserId,  String? takenByName,  DateTime? takenAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.status,_that.createdBy,_that.createdAt,_that.imagePath,_that.takenByUserId,_that.takenByName,_that.takenAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  ProductStatus status,  int createdBy,  DateTime createdAt,  String? imagePath,  int? takenByUserId,  String? takenByName,  DateTime? takenAt)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.description,_that.status,_that.createdBy,_that.createdAt,_that.imagePath,_that.takenByUserId,_that.takenByName,_that.takenAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  ProductStatus status,  int createdBy,  DateTime createdAt,  String? imagePath,  int? takenByUserId,  String? takenByName,  DateTime? takenAt)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.status,_that.createdBy,_that.createdAt,_that.imagePath,_that.takenByUserId,_that.takenByName,_that.takenAt);case _:
  return null;

}
}

}

/// @nodoc


class _Product extends Product {
  const _Product({required this.id, required this.name, required this.description, required this.status, required this.createdBy, required this.createdAt, this.imagePath, this.takenByUserId, this.takenByName, this.takenAt}): super._();
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  ProductStatus status;
@override final  int createdBy;
@override final  DateTime createdAt;
@override final  String? imagePath;
@override final  int? takenByUserId;
@override final  String? takenByName;
@override final  DateTime? takenAt;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.takenByUserId, takenByUserId) || other.takenByUserId == takenByUserId)&&(identical(other.takenByName, takenByName) || other.takenByName == takenByName)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,status,createdBy,createdAt,imagePath,takenByUserId,takenByName,takenAt);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, status: $status, createdBy: $createdBy, createdAt: $createdAt, imagePath: $imagePath, takenByUserId: $takenByUserId, takenByName: $takenByName, takenAt: $takenAt)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, ProductStatus status, int createdBy, DateTime createdAt, String? imagePath, int? takenByUserId, String? takenByName, DateTime? takenAt
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? status = null,Object? createdBy = null,Object? createdAt = null,Object? imagePath = freezed,Object? takenByUserId = freezed,Object? takenByName = freezed,Object? takenAt = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductStatus,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,takenByUserId: freezed == takenByUserId ? _self.takenByUserId : takenByUserId // ignore: cast_nullable_to_non_nullable
as int?,takenByName: freezed == takenByName ? _self.takenByName : takenByName // ignore: cast_nullable_to_non_nullable
as String?,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

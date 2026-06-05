// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_qr_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductQrPayload {

 String get app; String get type; String get id; String get name;
/// Create a copy of ProductQrPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductQrPayloadCopyWith<ProductQrPayload> get copyWith => _$ProductQrPayloadCopyWithImpl<ProductQrPayload>(this as ProductQrPayload, _$identity);

  /// Serializes this ProductQrPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductQrPayload&&(identical(other.app, app) || other.app == app)&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,app,type,id,name);

@override
String toString() {
  return 'ProductQrPayload(app: $app, type: $type, id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $ProductQrPayloadCopyWith<$Res>  {
  factory $ProductQrPayloadCopyWith(ProductQrPayload value, $Res Function(ProductQrPayload) _then) = _$ProductQrPayloadCopyWithImpl;
@useResult
$Res call({
 String app, String type, String id, String name
});




}
/// @nodoc
class _$ProductQrPayloadCopyWithImpl<$Res>
    implements $ProductQrPayloadCopyWith<$Res> {
  _$ProductQrPayloadCopyWithImpl(this._self, this._then);

  final ProductQrPayload _self;
  final $Res Function(ProductQrPayload) _then;

/// Create a copy of ProductQrPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? app = null,Object? type = null,Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductQrPayload].
extension ProductQrPayloadPatterns on ProductQrPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductQrPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductQrPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductQrPayload value)  $default,){
final _that = this;
switch (_that) {
case _ProductQrPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductQrPayload value)?  $default,){
final _that = this;
switch (_that) {
case _ProductQrPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String app,  String type,  String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductQrPayload() when $default != null:
return $default(_that.app,_that.type,_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String app,  String type,  String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _ProductQrPayload():
return $default(_that.app,_that.type,_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String app,  String type,  String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ProductQrPayload() when $default != null:
return $default(_that.app,_that.type,_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductQrPayload extends ProductQrPayload {
  const _ProductQrPayload({required this.app, required this.type, required this.id, required this.name}): super._();
  factory _ProductQrPayload.fromJson(Map<String, dynamic> json) => _$ProductQrPayloadFromJson(json);

@override final  String app;
@override final  String type;
@override final  String id;
@override final  String name;

/// Create a copy of ProductQrPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductQrPayloadCopyWith<_ProductQrPayload> get copyWith => __$ProductQrPayloadCopyWithImpl<_ProductQrPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductQrPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductQrPayload&&(identical(other.app, app) || other.app == app)&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,app,type,id,name);

@override
String toString() {
  return 'ProductQrPayload(app: $app, type: $type, id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ProductQrPayloadCopyWith<$Res> implements $ProductQrPayloadCopyWith<$Res> {
  factory _$ProductQrPayloadCopyWith(_ProductQrPayload value, $Res Function(_ProductQrPayload) _then) = __$ProductQrPayloadCopyWithImpl;
@override @useResult
$Res call({
 String app, String type, String id, String name
});




}
/// @nodoc
class __$ProductQrPayloadCopyWithImpl<$Res>
    implements _$ProductQrPayloadCopyWith<$Res> {
  __$ProductQrPayloadCopyWithImpl(this._self, this._then);

  final _ProductQrPayload _self;
  final $Res Function(_ProductQrPayload) _then;

/// Create a copy of ProductQrPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? app = null,Object? type = null,Object? id = null,Object? name = null,}) {
  return _then(_ProductQrPayload(
app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

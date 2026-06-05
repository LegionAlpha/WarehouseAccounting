// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_qr_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductQrPayload _$ProductQrPayloadFromJson(Map<String, dynamic> json) =>
    _ProductQrPayload(
      app: json['app'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductQrPayloadToJson(_ProductQrPayload instance) =>
    <String, dynamic>{
      'app': instance.app,
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
    };

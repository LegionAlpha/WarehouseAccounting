import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_qr_payload.freezed.dart';
part 'product_qr_payload.g.dart';

@freezed
abstract class ProductQrPayload with _$ProductQrPayload {
  const ProductQrPayload._();

  const factory ProductQrPayload({
    required String app,
    required String type,
    required String id,
    required String name,
  }) = _ProductQrPayload;

  factory ProductQrPayload.fromJson(Map<String, dynamic> json) =>
      _$ProductQrPayloadFromJson(json);

  factory ProductQrPayload.forProduct({
    required String id,
    required String name,
  }) => ProductQrPayload(
    app: appIdentifier,
    type: productType,
    id: id,
    name: name,
  );

  static const String appIdentifier = 'warehouse_accounting';
  static const String productType = 'product';

  bool get isValidProduct =>
      app == appIdentifier && type == productType && id.isNotEmpty;
}

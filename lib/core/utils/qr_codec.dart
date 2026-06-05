import 'dart:convert';

import 'package:warehouse_accounting/domain/entities/product_qr_payload.dart';

sealed class QrScanResult {
  const QrScanResult();
}

final class QrScanEmpty extends QrScanResult {
  const QrScanEmpty();
}

final class QrScanInvalid extends QrScanResult {
  const QrScanInvalid();
}

final class QrScanProduct extends QrScanResult {
  const QrScanProduct(this.payload);
  final ProductQrPayload payload;
}

abstract final class QrCodec {
  static String encode(ProductQrPayload payload) =>
      jsonEncode(payload.toJson());

  static QrScanResult parse(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const QrScanEmpty();
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return const QrScanInvalid();
      }
      final payload = ProductQrPayload.fromJson(decoded);
      if (!payload.isValidProduct) {
        return const QrScanInvalid();
      }
      return QrScanProduct(payload);
    } catch (_) {
      return const QrScanInvalid();
    }
  }
}

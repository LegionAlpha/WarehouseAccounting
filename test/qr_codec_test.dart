import 'package:flutter_test/flutter_test.dart';
import 'package:warehouse_accounting/core/utils/qr_codec.dart';
import 'package:warehouse_accounting/domain/entities/product_qr_payload.dart';

void main() {
  group('QrCodec', () {
    test('round-trips a valid product payload', () {
      final encoded = QrCodec.encode(
        ProductQrPayload.forProduct(id: 'abc-123', name: 'Cordless drill'),
      );
      final result = QrCodec.parse(encoded);

      expect(result, isA<QrScanProduct>());
      expect((result as QrScanProduct).payload.id, 'abc-123');
      expect(result.payload.name, 'Cordless drill');
    });

    test('reports empty codes', () {
      expect(QrCodec.parse(''), isA<QrScanEmpty>());
      expect(QrCodec.parse('   '), isA<QrScanEmpty>());
      expect(QrCodec.parse(null), isA<QrScanEmpty>());
    });

    test('reports non-JSON codes as invalid', () {
      expect(QrCodec.parse('just some text'), isA<QrScanInvalid>());
    });

    test('reports JSON from another app as invalid', () {
      const foreign =
          '{"app":"other_app","type":"product","id":"x","name":"y"}';
      expect(QrCodec.parse(foreign), isA<QrScanInvalid>());
    });
  });
}

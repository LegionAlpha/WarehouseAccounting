import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String description,
    required ProductStatus status,
    required int createdBy,
    required DateTime createdAt,
    String? imagePath,
    int? takenByUserId,
    String? takenByName,
    DateTime? takenAt,
  }) = _Product;

  bool get isAvailable => status == ProductStatus.available;
  bool get isTaken => status == ProductStatus.taken;

  String get shortDescription {
    final trimmed = description.trim();
    if (trimmed.isEmpty) return '';
    const maxLength = 80;
    if (trimmed.length <= maxLength) return trimmed;
    return '${trimmed.substring(0, maxLength).trimRight()}…';
  }

  bool isHeldBy(int userId) => isTaken && takenByUserId == userId;
}

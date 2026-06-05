import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warehouse_accounting/domain/enums/log_action.dart';

part 'product_log.freezed.dart';

@freezed
abstract class ProductLog with _$ProductLog {
  const factory ProductLog({
    required int id,
    required String productId,
    required int userId,
    required String userName,
    required LogAction action,
    required DateTime timestamp,
  }) = _ProductLog;
}

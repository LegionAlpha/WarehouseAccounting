import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';

class ProductActions {
  ProductActions(this._ref);

  final Ref _ref;

  Future<Product> take(String productId) {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw const UserNotFoundException();
    return _ref
        .read(productRepositoryProvider)
        .takeProduct(productId: productId, userId: user.id);
  }

  Future<Product> returnItem(String productId) {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw const UserNotFoundException();
    return _ref
        .read(productRepositoryProvider)
        .returnProduct(productId: productId, userId: user.id);
  }

  Future<int> seedDemoProducts({int count = 30}) {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw const UserNotFoundException();
    return _ref
        .read(productRepositoryProvider)
        .seedDemoProducts(count: count, createdBy: user.id);
  }
}

final productActionsProvider = Provider<ProductActions>(ProductActions.new);

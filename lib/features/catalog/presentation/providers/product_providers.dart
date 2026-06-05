import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_log.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';

final productsProvider = StreamProvider<List<Product>>(
  (ref) => ref.watch(productRepositoryProvider).watchProducts(),
);

final productProvider = StreamProvider.family<Product?, String>(
  (ref, id) => ref.watch(productRepositoryProvider).watchProduct(id),
);

final productHistoryProvider = StreamProvider.family<List<ProductLog>, String>(
  (ref, id) => ref.watch(productRepositoryProvider).watchHistory(id),
);

final myBorrowedProductsProvider = StreamProvider<List<Product>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return Stream<List<Product>>.value(const []);
  }
  return ref.watch(productRepositoryProvider).watchProductsTakenBy(user.id);
});

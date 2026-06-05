import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_log.dart';

abstract interface class ProductRepository {
  Stream<List<Product>> watchProducts();

  Stream<Product?> watchProduct(String id);

  Future<Product?> findById(String id);

  Stream<List<Product>> watchProductsTakenBy(int userId);

  Stream<List<ProductLog>> watchHistory(String productId);

  Future<Product> createProduct({
    required String name,
    required String description,
    required int createdBy,
    String? imagePath,
  });

  Future<int> seedDemoProducts({required int count, required int createdBy});

  Future<Product> takeProduct({required String productId, required int userId});

  Future<Product> returnProduct({
    required String productId,
    required int userId,
  });
}

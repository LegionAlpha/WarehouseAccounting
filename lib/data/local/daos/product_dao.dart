import 'package:drift/drift.dart';
import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/tables/product_logs_table.dart';
import 'package:warehouse_accounting/data/local/tables/products_table.dart';
import 'package:warehouse_accounting/data/local/tables/users_table.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';

part 'product_dao.g.dart';

class ProductWithHolder {
  const ProductWithHolder(this.product, this.holderName);

  final ProductRow product;
  final String? holderName;
}

class ProductLogWithUser {
  const ProductLogWithUser(this.log, this.userName);

  final ProductLogRow log;
  final String userName;
}

@DriftAccessor(tables: [Products, Users, ProductLogs])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  ProductWithHolder _mapJoined(TypedResult row, $UsersTable holder) {
    return ProductWithHolder(
      row.readTable(products),
      row.readTableOrNull(holder)?.name,
    );
  }

  Stream<List<ProductWithHolder>> watchProducts() {
    final holder = alias(users, 'holder');
    final query = select(products).join([
      leftOuterJoin(holder, holder.id.equalsExp(products.takenBy)),
    ])..orderBy([OrderingTerm.desc(products.createdAt)]);
    return query.watch().map(
      (rows) => rows.map((r) => _mapJoined(r, holder)).toList(),
    );
  }

  Stream<ProductWithHolder?> watchProduct(String id) {
    final holder = alias(users, 'holder');
    final query = select(products).join([
      leftOuterJoin(holder, holder.id.equalsExp(products.takenBy)),
    ])..where(products.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row == null ? null : _mapJoined(row, holder),
    );
  }

  Future<ProductWithHolder?> findById(String id) async {
    final holder = alias(users, 'holder');
    final row = await (select(products).join([
      leftOuterJoin(holder, holder.id.equalsExp(products.takenBy)),
    ])..where(products.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapJoined(row, holder);
  }

  Stream<List<ProductWithHolder>> watchProductsTakenBy(int userId) {
    final holder = alias(users, 'holder');
    final query =
        select(
            products,
          ).join([leftOuterJoin(holder, holder.id.equalsExp(products.takenBy))])
          ..where(products.takenBy.equals(userId))
          ..orderBy([OrderingTerm.desc(products.takenAt)]);
    return query.watch().map(
      (rows) => rows.map((r) => _mapJoined(r, holder)).toList(),
    );
  }

  Stream<List<ProductLogWithUser>> watchHistory(String productId) {
    final query =
        select(
            productLogs,
          ).join([innerJoin(users, users.id.equalsExp(productLogs.userId))])
          ..where(productLogs.productId.equals(productId))
          ..orderBy([OrderingTerm.desc(productLogs.timestamp)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (r) => ProductLogWithUser(
              r.readTable(productLogs),
              r.readTable(users).name,
            ),
          )
          .toList(),
    );
  }

  Future<ProductRow?> findRow(String id) {
    return (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  Future<void> insertProducts(List<ProductsCompanion> rows) {
    return batch((b) => b.insertAll(products, rows));
  }

  Future<void> markTaken({
    required String id,
    required int userId,
    required DateTime at,
  }) {
    return (update(products)..where((p) => p.id.equals(id))).write(
      ProductsCompanion(
        status: const Value(ProductStatus.taken),
        takenBy: Value(userId),
        takenAt: Value(at),
      ),
    );
  }

  Future<void> markAvailable(String id) {
    return (update(products)..where((p) => p.id.equals(id))).write(
      const ProductsCompanion(
        status: Value(ProductStatus.available),
        takenBy: Value(null),
        takenAt: Value(null),
      ),
    );
  }

  Future<void> insertLog(ProductLogsCompanion log) {
    return into(productLogs).insert(log);
  }
}

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:warehouse_accounting/data/local/daos/product_dao.dart';
import 'package:warehouse_accounting/data/local/daos/user_dao.dart';
import 'package:warehouse_accounting/data/local/tables/product_logs_table.dart';
import 'package:warehouse_accounting/data/local/tables/products_table.dart';
import 'package:warehouse_accounting/data/local/tables/users_table.dart';
import 'package:warehouse_accounting/domain/enums/log_action.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Users, Products, ProductLogs],
  daos: [UserDao, ProductDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(name: 'warehouse');
}

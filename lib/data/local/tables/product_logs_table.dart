import 'package:drift/drift.dart';
import 'package:warehouse_accounting/data/local/tables/products_table.dart';
import 'package:warehouse_accounting/data/local/tables/users_table.dart';
import 'package:warehouse_accounting/domain/enums/log_action.dart';

@DataClassName('ProductLogRow')
class ProductLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId =>
      text().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get action => textEnum<LogAction>()();
  DateTimeColumn get timestamp => dateTime()();
}

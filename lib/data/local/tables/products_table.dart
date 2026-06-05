import 'package:drift/drift.dart';
import 'package:warehouse_accounting/data/local/tables/users_table.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';

@DataClassName('ProductRow')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get imagePath => text().nullable()();
  TextColumn get status => textEnum<ProductStatus>()();
  @ReferenceName('createdProducts')
  IntColumn get createdBy => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime()();
  @ReferenceName('heldProducts')
  IntColumn get takenBy => integer().nullable().references(Users, #id)();
  DateTimeColumn get takenAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

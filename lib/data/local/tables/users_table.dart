import 'package:drift/drift.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';

@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get email => text().withLength(min: 3, max: 255).unique()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  TextColumn get role => textEnum<UserRole>()();
  DateTimeColumn get createdAt => dateTime()();
}

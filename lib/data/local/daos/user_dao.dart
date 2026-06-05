import 'package:drift/drift.dart';
import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/tables/users_table.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<UserRow?> findByEmail(String email) {
    return (select(
      users,
    )..where((u) => u.email.equals(email))).getSingleOrNull();
  }

  Future<UserRow?> findById(int id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  Future<int> countUsers() async {
    final counter = countAll();
    final row = await (selectOnly(users)..addColumns([counter])).getSingle();
    return row.read(counter) ?? 0;
  }

  Future<UserRow> insertUser(UsersCompanion user) {
    return into(users).insertReturning(user);
  }

  Stream<List<UserRow>> watchAllUsers() {
    return (select(users)..orderBy([
          (u) => OrderingTerm.asc(u.role),
          (u) => OrderingTerm.asc(u.createdAt),
        ]))
        .watch();
  }

  Future<void> updateRole(int id, UserRole role) {
    return (update(
      users,
    )..where((u) => u.id.equals(id))).write(UsersCompanion(role: Value(role)));
  }
}

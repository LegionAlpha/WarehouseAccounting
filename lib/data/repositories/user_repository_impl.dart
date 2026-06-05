import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/daos/user_dao.dart';
import 'package:warehouse_accounting/data/mappers/entity_mappers.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';
import 'package:warehouse_accounting/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  UserDao get _users => _db.userDao;

  @override
  Stream<List<AppUser>> watchUsers() {
    return _users.watchAllUsers().map(
      (rows) => rows.map((r) => r.toEntity()).toList(),
    );
  }

  @override
  Future<void> updateRole({required int userId, required UserRole role}) {
    return _users.updateRole(userId, role);
  }
}

import 'package:warehouse_accounting/core/constants/demo_admin.dart';
import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/daos/user_dao.dart';
import 'package:warehouse_accounting/data/mappers/entity_mappers.dart';
import 'package:warehouse_accounting/data/security/password_hasher.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AppDatabase database,
    required PasswordHasher hasher,
  }) : _db = database,
       _hasher = hasher;

  final AppDatabase _db;
  final PasswordHasher _hasher;

  UserDao get _users => _db.userDao;

  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = _normalizeEmail(email);
    final existing = await _users.findByEmail(normalizedEmail);
    if (existing != null) {
      throw const EmailAlreadyInUseException();
    }

    final hashed = _hasher.hash(password);
    final row = await _users.insertUser(
      UsersCompanion.insert(
        name: name.trim(),
        email: normalizedEmail,
        passwordHash: hashed.hash,
        salt: hashed.salt,
        role: UserRole.employee,
        createdAt: DateTime.now(),
      ),
    );
    return row.toEntity();
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final row = await _users.findByEmail(_normalizeEmail(email));
    if (row == null) {
      throw const InvalidCredentialsException();
    }
    final matches = _hasher.verify(
      password: password,
      hash: row.passwordHash,
      salt: row.salt,
    );
    if (!matches) {
      throw const InvalidCredentialsException();
    }
    return row.toEntity();
  }

  @override
  Future<AppUser?> findById(int id) async {
    final row = await _users.findById(id);
    return row?.toEntity();
  }

  @override
  Future<void> seedAdminIfNeeded() async {
    final userCount = await _users.countUsers();
    if (userCount > 0) return;

    final hashed = _hasher.hash(DemoAdmin.password);
    await _users.insertUser(
      UsersCompanion.insert(
        name: DemoAdmin.name,
        email: DemoAdmin.email,
        passwordHash: hashed.hash,
        salt: hashed.salt,
        role: UserRole.admin,
        createdAt: DateTime.now(),
      ),
    );
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();
}

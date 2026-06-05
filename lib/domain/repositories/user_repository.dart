import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';

abstract interface class UserRepository {
  Stream<List<AppUser>> watchUsers();

  Future<void> updateRole({required int userId, required UserRole role});
}

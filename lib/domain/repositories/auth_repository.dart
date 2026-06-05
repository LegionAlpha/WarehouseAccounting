import 'package:warehouse_accounting/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AppUser> login({required String email, required String password});

  Future<AppUser?> findById(int id);

  Future<void> seedAdminIfNeeded();
}

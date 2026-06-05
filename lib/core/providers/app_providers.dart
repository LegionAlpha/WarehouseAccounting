import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_accounting/core/session/session_store.dart';
import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/repositories/auth_repository_impl.dart';
import 'package:warehouse_accounting/data/repositories/product_repository_impl.dart';
import 'package:warehouse_accounting/data/repositories/user_repository_impl.dart';
import 'package:warehouse_accounting/data/security/password_hasher.dart';
import 'package:warehouse_accounting/domain/repositories/auth_repository.dart';
import 'package:warehouse_accounting/domain/repositories/product_repository.dart';
import 'package:warehouse_accounting/domain/repositories/user_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final passwordHasherProvider = Provider<PasswordHasher>(
  (ref) => const PasswordHasher(),
);

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

final sessionStoreProvider = Provider<SessionStore>(
  (ref) => SessionStore(ref.watch(sharedPreferencesProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    database: ref.watch(databaseProvider),
    hasher: ref.watch(passwordHasherProvider),
  ),
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    database: ref.watch(databaseProvider),
    uuid: ref.watch(uuidProvider),
  ),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(database: ref.watch(databaseProvider)),
);

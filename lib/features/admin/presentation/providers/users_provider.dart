import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';

final usersProvider = StreamProvider<List<AppUser>>(
  (ref) => ref.watch(userRepositoryProvider).watchUsers(),
);

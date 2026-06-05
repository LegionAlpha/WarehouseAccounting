import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse_accounting/app/app.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
  );
  await container.read(authRepositoryProvider).seedAdminIfNeeded();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const WarehouseApp(),
    ),
  );
}

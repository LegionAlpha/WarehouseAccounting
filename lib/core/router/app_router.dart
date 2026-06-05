import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/app/main_shell.dart';
import 'package:warehouse_accounting/app/splash_screen.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/features/add_product/presentation/screens/add_product_screen.dart';
import 'package:warehouse_accounting/features/admin/presentation/screens/user_management_screen.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/features/auth/presentation/screens/login_screen.dart';
import 'package:warehouse_accounting/features/auth/presentation/screens/register_screen.dart';
import 'package:warehouse_accounting/features/catalog/presentation/screens/catalog_screen.dart';
import 'package:warehouse_accounting/features/catalog/presentation/screens/product_detail_screen.dart';
import 'package:warehouse_accounting/features/profile/presentation/screens/my_borrowed_screen.dart';
import 'package:warehouse_accounting/features/profile/presentation/screens/profile_screen.dart';
import 'package:warehouse_accounting/features/qr/presentation/screens/qr_display_screen.dart';
import 'package:warehouse_accounting/features/qr/presentation/screens/scan_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authListenable = ValueNotifier<AuthState>(const AuthUnknown());
  ref.onDispose(authListenable.dispose);
  ref.listen<AuthState>(
    authControllerProvider,
    (_, next) => authListenable.value = next,
    fireImmediately: true,
  );

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final location = state.matchedLocation;

      if (auth.isResolving) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      final loggedIn = auth.isAuthenticated;
      final isAuthRoute =
          location == AppRoutes.login || location == AppRoutes.register;

      if (location == AppRoutes.splash) {
        return loggedIn ? AppRoutes.catalog : AppRoutes.login;
      }
      if (!loggedIn) {
        return isAuthRoute ? null : AppRoutes.login;
      }
      if (isAuthRoute) {
        return AppRoutes.catalog;
      }

      final isAdmin = auth.userOrNull?.isAdmin ?? false;
      final adminOnly =
          location == AppRoutes.addProduct || location == AppRoutes.users;
      if (!isAdmin && adminOnly) {
        return AppRoutes.catalog;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.catalog,
                builder: (_, _) => const CatalogScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, _) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: AppRoutes.scan, builder: (_, _) => const ScanScreen()),
      GoRoute(
        path: AppRoutes.addProduct,
        builder: (_, _) => const AddProductScreen(),
      ),
      GoRoute(
        path: AppRoutes.users,
        builder: (_, _) => const UserManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.myBorrowed,
        builder: (_, _) => const MyBorrowedScreen(),
      ),
      GoRoute(
        path: AppRoutes.productDetailPattern,
        builder: (_, state) =>
            ProductDetailScreen(productId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.productQrPattern,
        builder: (_, state) =>
            QrDisplayScreen(productId: state.pathParameters['id']!),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});

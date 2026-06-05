import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/repositories/auth_repository.dart';

sealed class AuthState {
  const AuthState();

  AppUser? get userOrNull => switch (this) {
    AuthAuthenticated(:final user) => user,
    _ => null,
  };

  bool get isAuthenticated => this is AuthAuthenticated;

  bool get isResolving => this is AuthUnknown;
}

final class AuthUnknown extends AuthState {
  const AuthUnknown();
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final AppUser user;
}

class AuthController extends Notifier<AuthState> {
  AuthRepository get _auth => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    Future.microtask(_restoreSession);
    return const AuthUnknown();
  }

  Future<void> _restoreSession() async {
    try {
      final session = ref.read(sessionStoreProvider);
      final savedId = session.readUserId();
      if (savedId == null) {
        state = const AuthUnauthenticated();
        return;
      }
      final user = await _auth.findById(savedId);
      if (user == null) {
        await session.clear();
        state = const AuthUnauthenticated();
      } else {
        state = AuthAuthenticated(user);
      }
    } catch (_) {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    final user = await _auth.login(email: email, password: password);
    await ref.read(sessionStoreProvider).saveUserId(user.id);
    state = AuthAuthenticated(user);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await _auth.register(
      name: name,
      email: email,
      password: password,
    );
    await ref.read(sessionStoreProvider).saveUserId(user.id);
    state = AuthAuthenticated(user);
  }

  Future<void> logout() async {
    await ref.read(sessionStoreProvider).clear();
    state = const AuthUnauthenticated();
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authControllerProvider).userOrNull,
);

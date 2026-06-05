import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';

part 'app_user.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required int id,
    required String name,
    required String email,
    required UserRole role,
    required DateTime createdAt,
  }) = _AppUser;

  bool get isAdmin => role == UserRole.admin;

  String get initial {
    final source = name.trim().isNotEmpty ? name.trim() : email;
    return source.isEmpty ? '?' : source.substring(0, 1).toUpperCase();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/date_formatting.dart';
import 'package:warehouse_accounting/core/utils/localization_extensions.dart';
import 'package:warehouse_accounting/core/utils/snackbar_extension.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';
import 'package:warehouse_accounting/features/admin/presentation/providers/users_provider.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class UserManagementScreen extends ConsumerWidget {
  const UserManagementScreen({super.key});

  Future<void> _changeRole(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
  ) async {
    final l10n = AppLocalizations.of(context);
    final newRole = await showModalBottomSheet<UserRole>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final role in UserRole.values)
              ListTile(
                leading: Icon(
                  role == user.role
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: role == user.role
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(role.label(l10n)),
                onTap: () => Navigator.pop(context, role),
              ),
          ],
        ),
      ),
    );

    if (newRole != null && newRole != user.role) {
      await ref
          .read(userRepositoryProvider)
          .updateRole(userId: user.id, role: newRole);
      if (context.mounted) context.showSuccessSnackBar(l10n.roleChanged);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final usersAsync = ref.watch(usersProvider);
    final currentUserId = ref.watch(currentUserProvider)?.id;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.usersTitle)),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => InfoView(
          icon: Icons.error_outline_rounded,
          title: l10n.errorGeneric,
        ),
        data: (users) {
          if (users.isEmpty) {
            return InfoView(icon: Icons.group_outlined, title: l10n.usersEmpty);
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            itemCount: users.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = users[index];
              final isSelf = user.id == currentUserId;
              return _UserTile(
                user: user,
                isSelf: isSelf,
                onChangeRole: isSelf
                    ? null
                    : () => _changeRole(context, ref, user),
              );
            },
          );
        },
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({
    required this.user,
    required this.isSelf,
    required this.onChangeRole,
  });

  final AppUser user;
  final bool isSelf;
  final VoidCallback? onChangeRole;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isAdmin = user.role == UserRole.admin;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      leading: CircleAvatar(
        backgroundColor: isAdmin
            ? scheme.primaryContainer
            : scheme.surfaceContainerHighest,
        child: Text(
          user.initial,
          style: TextStyle(
            color: isAdmin
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (isSelf) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              '(${l10n.youLabel})',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(
            l10n.registeredOn(context.formatDate(user.createdAt)),
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      trailing: onChangeRole == null
          ? Text(
              user.role.label(l10n),
              style: TextStyle(
                color: isAdmin ? scheme.primary : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            )
          : TextButton(
              onPressed: onChangeRole,
              child: Text(user.role.label(l10n)),
            ),
      isThreeLine: true,
      onTap: onChangeRole,
    );
  }
}

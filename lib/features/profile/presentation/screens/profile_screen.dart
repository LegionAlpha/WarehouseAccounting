import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/settings/settings_controller.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/localization_extensions.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_actions.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
    if (shouldLogout ?? false) {
      await ref.read(authControllerProvider.notifier).logout();
    }
  }

  Future<void> _seedDemoData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final added = await ref.read(productActionsProvider).seedDemoProducts();
    messenger.showSnackBar(SnackBar(content: Text(l10n.seedDataDone(added))));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _UserHeader(user: user),
          const SizedBox(height: AppSpacing.xl),
          _SectionLabel(l10n.settingsAppearance),
          const SizedBox(height: AppSpacing.sm),
          const _ThemeModeSelector(),
          const SizedBox(height: AppSpacing.lg),
          const _LanguageSelector(),
          const SizedBox(height: AppSpacing.xl),
          Card(
            child: Column(
              children: [
                if (user.isAdmin)
                  ListTile(
                    leading: const Icon(Icons.manage_accounts_outlined),
                    title: Text(l10n.settingsManageUsers),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.push(AppRoutes.users),
                  ),
                if (user.isAdmin) const Divider(height: 1),
                if (user.isAdmin)
                  ListTile(
                    leading: const Icon(Icons.dataset_outlined),
                    title: Text(l10n.settingsSeedData),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => unawaited(_seedDemoData(context, ref)),
                  ),
                if (user.isAdmin) const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text(l10n.settingsMyBorrowed),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(AppRoutes.myBorrowed),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          OutlinedButton.icon(
            onPressed: () => _confirmLogout(context, ref),
            icon: const Icon(Icons.logout_rounded),
            label: Text(l10n.logout),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: scheme.primaryContainer,
              child: Text(
                user.initial,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _RoleChip(role: user.role, label: user.role.label(l10n)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.role, required this.label});

  final UserRole role;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAdmin = role == UserRole.admin;
    final background = isAdmin
        ? scheme.primaryContainer
        : scheme.surfaceContainerHighest;
    final foreground = isAdmin
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAdmin ? Icons.shield_outlined : Icons.badge_outlined,
            size: 15,
            color: foreground,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _ThemeModeSelector extends ConsumerWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final mode = ref.watch(settingsControllerProvider).themeMode;
    final controller = ref.read(settingsControllerProvider.notifier);

    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(
          value: ThemeMode.system,
          icon: const Icon(Icons.brightness_auto_outlined),
          label: Text(l10n.themeSystem),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          icon: const Icon(Icons.light_mode_outlined),
          label: Text(l10n.themeLight),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: const Icon(Icons.dark_mode_outlined),
          label: Text(l10n.themeDark),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) =>
          unawaited(controller.setThemeMode(selection.first)),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  static const String _system = 'system';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(settingsControllerProvider).locale;
    final controller = ref.read(settingsControllerProvider.notifier);
    final selected = locale?.languageCode ?? _system;

    return SegmentedButton<String>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(value: _system, label: Text(l10n.languageSystem)),
        ButtonSegment(value: 'ru', label: Text(l10n.languageRussian)),
        ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
      ],
      selected: {selected},
      onSelectionChanged: (selection) {
        final value = selection.first;
        unawaited(
          controller.setLocale(value == _system ? null : Locale(value)),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehouse_accounting/core/settings/settings_controller.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class LanguageMenuButton extends ConsumerWidget {
  const LanguageMenuButton({super.key});

  static const String _system = 'system';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(settingsControllerProvider).locale;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.translate_rounded),
      tooltip: l10n.settingsLanguage,
      initialValue: current?.languageCode ?? _system,
      onSelected: (value) {
        unawaited(
          ref
              .read(settingsControllerProvider.notifier)
              .setLocale(value == _system ? null : Locale(value)),
        );
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: _system, child: Text(l10n.languageSystem)),
        PopupMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
        PopupMenuItem(value: 'ru', child: Text(l10n.languageRussian)),
      ],
    );
  }
}

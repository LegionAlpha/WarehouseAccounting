import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const int _catalogTab = 0;
  static const int _scanTab = 1;
  static const int _profileTab = 2;

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case _catalogTab:
        navigationShell.goBranch(0);
      case _scanTab:
        context.push(AppRoutes.scan);
      case _profileTab:
        navigationShell.goBranch(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedIndex = navigationShell.currentIndex == 0
        ? _catalogTab
        : _profileTab;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.inventory_2_outlined),
            selectedIcon: const Icon(Icons.inventory_2),
            label: l10n.navCatalog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: l10n.navScan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}

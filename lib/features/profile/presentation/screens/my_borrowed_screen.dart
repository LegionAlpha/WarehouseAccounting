import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_providers.dart';
import 'package:warehouse_accounting/features/catalog/presentation/widgets/product_card.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class MyBorrowedScreen extends ConsumerWidget {
  const MyBorrowedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final borrowedAsync = ref.watch(myBorrowedProductsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsMyBorrowed)),
      body: borrowedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => InfoView(
          icon: Icons.error_outline_rounded,
          title: l10n.errorGeneric,
        ),
        data: (products) {
          if (products.isEmpty) {
            return InfoView(
              icon: Icons.inventory_2_outlined,
              title: l10n.myBorrowedEmpty,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => context.push(AppRoutes.productDetail(product.id)),
              );
            },
          );
        },
      ),
    );
  }
}

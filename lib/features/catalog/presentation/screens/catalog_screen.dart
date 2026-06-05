import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_providers.dart';
import 'package:warehouse_accounting/features/catalog/presentation/widgets/product_card.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

enum _CatalogFilter { all, available, taken }

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _searchController = TextEditingController();
  _CatalogFilter _filter = _CatalogFilter.all;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _applyFilters(List<Product> products) {
    final query = _query.trim().toLowerCase();
    return products.where((product) {
      final matchesStatus = switch (_filter) {
        _CatalogFilter.all => true,
        _CatalogFilter.available => product.isAvailable,
        _CatalogFilter.taken => product.isTaken,
      };
      if (!matchesStatus) return false;
      if (query.isEmpty) return true;
      return product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final productsAsync = ref.watch(productsProvider);
    final isAdmin = ref.watch(currentUserProvider)?.isAdmin ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catalogTitle)),
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.addProduct),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.addProductTitle),
            )
          : null,
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => InfoView(
          icon: Icons.error_outline_rounded,
          title: l10n.errorGeneric,
          action: FilledButton.tonal(
            onPressed: () => ref.invalidate(productsProvider),
            child: Text(l10n.actionRetry),
          ),
        ),
        data: (products) {
          if (products.isEmpty) {
            return InfoView(
              icon: Icons.inventory_2_outlined,
              title: l10n.catalogEmpty,
              message: isAdmin
                  ? l10n.catalogEmptyAdmin
                  : l10n.catalogEmployeeEmpty,
            );
          }

          final filtered = _applyFilters(products);
          return Column(
            children: [
              _SearchField(
                controller: _searchController,
                hint: l10n.catalogSearchHint,
                onChanged: (value) => setState(() => _query = value),
              ),
              _FilterChips(
                selected: _filter,
                onSelected: (filter) => setState(() => _filter = filter),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? InfoView(
                        icon: Icons.search_off_rounded,
                        title: l10n.catalogEmpty,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.sm,
                          AppSpacing.lg,
                          AppSpacing.xxl * 2,
                        ),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final product = filtered[index];
                          return ProductCard(
                            product: product,
                            onTap: () => context.push(
                              AppRoutes.productDetail(product.id),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.selected, required this.onSelected});

  final _CatalogFilter selected;
  final ValueChanged<_CatalogFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = <_CatalogFilter, String>{
      _CatalogFilter.all: l10n.filterAll,
      _CatalogFilter.available: l10n.filterAvailable,
      _CatalogFilter.taken: l10n.filterTaken,
    };

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          for (final entry in labels.entries) ...[
            ChoiceChip(
              label: Text(entry.value),
              selected: selected == entry.key,
              onSelected: (_) => onSelected(entry.key),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

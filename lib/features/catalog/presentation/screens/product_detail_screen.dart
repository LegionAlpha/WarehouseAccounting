import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/date_formatting.dart';
import 'package:warehouse_accounting/core/utils/localization_extensions.dart';
import 'package:warehouse_accounting/core/utils/snackbar_extension.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/core/widgets/product_image.dart';
import 'package:warehouse_accounting/core/widgets/product_status_badge.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_log.dart';
import 'package:warehouse_accounting/domain/enums/log_action.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_actions.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_providers.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  bool _isProcessing = false;

  Future<void> _take() => _run(
    (actions) => actions.take(widget.productId),
    (l10n, product) => l10n.actionResultTaken(product.name),
  );

  Future<void> _return() => _run(
    (actions) => actions.returnItem(widget.productId),
    (l10n, product) => l10n.actionResultReturned(product.name),
  );

  Future<void> _run(
    Future<Product> Function(ProductActions actions) action,
    String Function(AppLocalizations l10n, Product product) successMessage,
  ) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isProcessing = true);
    try {
      final product = await action(ref.read(productActionsProvider));
      if (mounted) context.showSuccessSnackBar(successMessage(l10n, product));
    } on AppException catch (error) {
      if (mounted) context.showErrorSnackBar(error.localizedMessage(l10n));
    } catch (_) {
      if (mounted) context.showErrorSnackBar(l10n.errorGeneric);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final productAsync = ref.watch(productProvider(widget.productId));
    final product = switch (productAsync) {
      AsyncData(:final value) => value,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(product?.name ?? l10n.productDetailTitle),
        actions: [
          if (product != null)
            IconButton(
              tooltip: l10n.buttonShowQr,
              icon: const Icon(Icons.qr_code_2_rounded),
              onPressed: () =>
                  context.push(AppRoutes.productQr(widget.productId)),
            ),
        ],
      ),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => InfoView(
          icon: Icons.error_outline_rounded,
          title: l10n.errorGeneric,
        ),
        data: (product) {
          if (product == null) {
            return InfoView(
              icon: Icons.search_off_rounded,
              title: l10n.scanErrorNotFound,
            );
          }
          return _DetailBody(productId: widget.productId, product: product);
        },
      ),
      bottomNavigationBar: product == null
          ? null
          : _ActionBar(
              product: product,
              currentUser: ref.watch(currentUserProvider),
              isProcessing: _isProcessing,
              onTake: _take,
              onReturn: _return,
            ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.productId, required this.product});

  final String productId;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final historyAsync = ref.watch(productHistoryProvider(productId));

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: ProductImage(imagePath: product.imagePath, iconSize: 64),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: ProductStatusBadge(status: product.status),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(l10n.sectionDescription),
              const SizedBox(height: AppSpacing.sm),
              Text(
                product.description.trim().isEmpty
                    ? l10n.noDescription
                    : product.description.trim(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontStyle: product.description.trim().isEmpty
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
              if (product.isTaken) ...[
                const SizedBox(height: AppSpacing.xl),
                _SectionHeader(l10n.sectionBorrowInfo),
                const SizedBox(height: AppSpacing.sm),
                _BorrowInfoCard(product: product),
              ],
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(l10n.sectionHistory),
              const SizedBox(height: AppSpacing.sm),
              historyAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, _) => Text(l10n.errorGeneric),
                data: (logs) => logs.isEmpty
                    ? Text(
                        l10n.historyEmpty,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      )
                    : Column(
                        children: [
                          for (final log in logs) _HistoryTile(log: log),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _BorrowInfoCard extends StatelessWidget {
  const _BorrowInfoCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final takenAt = product.takenAt;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.takenBy(product.takenByName ?? '—'),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            if (takenAt != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.takenAt(context.formatDateTime(takenAt)),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.log});

  final ProductLog log;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isTake = log.action == LogAction.taken;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            child: Icon(
              isTake ? Icons.logout_rounded : Icons.login_rounded,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isTake
                      ? l10n.historyTook(log.userName)
                      : l10n.historyReturned(log.userName),
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  context.formatDateTime(log.timestamp),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.product,
    required this.currentUser,
    required this.isProcessing,
    required this.onTake,
    required this.onReturn,
  });

  final Product product;
  final AppUser? currentUser;
  final bool isProcessing;
  final VoidCallback onTake;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final heldByMe = currentUser != null && product.isHeldBy(currentUser!.id);

    final Widget actionButton;
    if (product.isAvailable) {
      actionButton = FilledButton.icon(
        onPressed: isProcessing ? null : onTake,
        icon: _buttonIcon(Icons.download_rounded),
        label: Text(l10n.buttonTake),
      );
    } else if (heldByMe) {
      actionButton = FilledButton.icon(
        onPressed: isProcessing ? null : onReturn,
        icon: _buttonIcon(Icons.upload_rounded),
        label: Text(l10n.buttonReturn),
      );
    } else {
      actionButton = FilledButton.icon(
        onPressed: null,
        icon: const Icon(Icons.lock_outline_rounded),
        label: Text(l10n.statusTaken),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SizedBox(width: double.infinity, child: actionButton),
      ),
    );
  }

  Widget _buttonIcon(IconData icon) {
    if (isProcessing) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2.2),
      );
    }
    return Icon(icon);
  }
}

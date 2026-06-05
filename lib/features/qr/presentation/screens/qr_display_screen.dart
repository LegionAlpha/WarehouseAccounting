import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:warehouse_accounting/core/theme/app_colors.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/qr_codec.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_qr_payload.dart';
import 'package:warehouse_accounting/features/catalog/presentation/providers/product_providers.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class QrDisplayScreen extends ConsumerWidget {
  const QrDisplayScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final productAsync = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.qrTitle)),
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
          return _QrContent(product: product);
        },
      ),
    );
  }
}

class _QrContent extends StatelessWidget {
  const _QrContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final data = QrCodec.encode(
      ProductQrPayload.forProduct(id: product.id, name: product.name),
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadii.lg),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: QrImageView(
                data: data,
                size: 240,
                backgroundColor: AppColors.white,
                errorStateBuilder: (context, _) => SizedBox(
                  width: 240,
                  height: 240,
                  child: Center(child: Text(l10n.errorGeneric)),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.qrHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/theme/app_semantic_colors.dart';
import 'package:warehouse_accounting/core/utils/localization_extensions.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class ProductStatusBadge extends StatelessWidget {
  const ProductStatusBadge({super.key, required this.status});

  final ProductStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;
    final colors = AppSemanticColors.forStatus(status, brightness);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colors.foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            status.label(l10n),
            style: TextStyle(
              color: colors.foreground,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:warehouse_accounting/core/theme/app_colors.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';

@immutable
class StatusColors {
  const StatusColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}

abstract final class AppSemanticColors {
  static const StatusColors _availableLight = StatusColors(
    background: AppColors.availableBackgroundLight,
    foreground: AppColors.availableForegroundLight,
  );
  static const StatusColors _availableDark = StatusColors(
    background: AppColors.availableBackgroundDark,
    foreground: AppColors.availableForegroundDark,
  );
  static const StatusColors _takenLight = StatusColors(
    background: AppColors.takenBackgroundLight,
    foreground: AppColors.takenForegroundLight,
  );
  static const StatusColors _takenDark = StatusColors(
    background: AppColors.takenBackgroundDark,
    foreground: AppColors.takenForegroundDark,
  );

  static StatusColors forStatus(ProductStatus status, Brightness brightness) {
    final isLight = brightness == Brightness.light;
    return switch (status) {
      ProductStatus.available => isLight ? _availableLight : _availableDark,
      ProductStatus.taken => isLight ? _takenLight : _takenDark,
    };
  }
}

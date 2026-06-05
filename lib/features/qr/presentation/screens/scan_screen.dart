import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/theme/app_colors.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/qr_codec.dart';
import 'package:warehouse_accounting/core/utils/snackbar_extension.dart';
import 'package:warehouse_accounting/core/widgets/info_view.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
  );
  bool _isHandling = false;
  DateTime? _lastErrorShownAt;

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isHandling || !mounted) return;
    final l10n = AppLocalizations.of(context);
    final raw = capture.barcodes.isEmpty
        ? null
        : capture.barcodes.first.rawValue;

    switch (QrCodec.parse(raw)) {
      case QrScanEmpty():
        _showTransientError(l10n.scanErrorEmpty);
      case QrScanInvalid():
        _showTransientError(l10n.scanErrorInvalid);
      case QrScanProduct(:final payload):
        _isHandling = true;
        final product = await ref
            .read(productRepositoryProvider)
            .findById(payload.id);
        if (!mounted) return;
        if (product == null) {
          _showTransientError(l10n.scanErrorNotFound);
          _isHandling = false;
          return;
        }
        await context.push(AppRoutes.productDetail(product.id));
        if (mounted) _isHandling = false;
    }
  }

  void _showTransientError(String message) {
    final now = DateTime.now();
    if (_lastErrorShownAt != null &&
        now.difference(_lastErrorShownAt!) < const Duration(seconds: 2)) {
      return;
    }
    _lastErrorShownAt = now;
    context.showErrorSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanTitle),
        actions: [
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, state, _) {
              final isOn = state.torchState == TorchState.on;
              if (state.torchState == TorchState.unavailable) {
                return const SizedBox.shrink();
              }
              return IconButton(
                tooltip: l10n.scanTorch,
                icon: Icon(
                  isOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                ),
                onPressed: () => unawaited(_controller.toggleTorch()),
              );
            },
          ),
          IconButton(
            tooltip: l10n.scanFlip,
            icon: const Icon(Icons.cameraswitch_rounded),
            onPressed: () => unawaited(_controller.switchCamera()),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) => _ScannerError(
              error: error,
              onRetry: () => unawaited(_controller.start()),
            ),
          ),
          IgnorePointer(child: _ScannerOverlay(hint: l10n.scanHint)),
        ],
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white, width: 3),
            borderRadius: BorderRadius.circular(AppRadii.xl),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Text(
            hint,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class _ScannerError extends StatelessWidget {
  const _ScannerError({required this.error, required this.onRetry});

  final MobileScannerException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (String message, bool canRetry) = switch (error.errorCode) {
      MobileScannerErrorCode.permissionDenied => (
        l10n.scanErrorPermission,
        true,
      ),
      MobileScannerErrorCode.unsupported => (l10n.scanErrorNoCamera, false),
      _ => (l10n.errorGeneric, true),
    };

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: InfoView(
        icon: error.errorCode == MobileScannerErrorCode.permissionDenied
            ? Icons.no_photography_outlined
            : Icons.videocam_off_outlined,
        title: message,
        action: canRetry
            ? FilledButton.tonal(
                onPressed: onRetry,
                child: Text(
                  error.errorCode == MobileScannerErrorCode.permissionDenied
                      ? l10n.buttonGrantPermission
                      : l10n.actionRetry,
                ),
              )
            : null,
      ),
    );
  }
}

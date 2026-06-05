import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar(String message) => _show(message, isError: false);

  void showErrorSnackBar(String message) => _show(message, isError: true);

  void _show(String message, {required bool isError}) {
    final messenger = ScaffoldMessenger.of(this);
    final scheme = Theme.of(this).colorScheme;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: isError
                  ? scheme.onErrorContainer
                  : scheme.onInverseSurface,
            ),
          ),
          backgroundColor: isError
              ? scheme.errorContainer
              : scheme.inverseSurface,
        ),
      );
  }
}

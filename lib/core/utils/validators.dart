import 'package:warehouse_accounting/l10n/app_localizations.dart';

abstract final class Validators {
  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static const int passwordMinLength = 6;

  static String? email(String? value, AppLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return l10n.validationEmailRequired;
    if (!_emailRegex.hasMatch(trimmed)) return l10n.validationEmailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final text = value ?? '';
    if (text.isEmpty) return l10n.validationPasswordRequired;
    if (text.length < passwordMinLength) {
      return l10n.validationPasswordTooShort(passwordMinLength);
    }
    return null;
  }

  static String? name(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').isEmpty) return l10n.validationNameRequired;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String original,
    AppLocalizations l10n,
  ) {
    if (value != original) return l10n.validationConfirmMismatch;
    return null;
  }

  static String? productName(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').isEmpty) {
      return l10n.validationProductNameRequired;
    }
    return null;
  }
}

import 'package:warehouse_accounting/domain/enums/product_status.dart';
import 'package:warehouse_accounting/domain/enums/user_role.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

extension AppExceptionL10n on AppException {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    EmailAlreadyInUseException() => l10n.errorEmailTaken,
    InvalidCredentialsException() => l10n.errorInvalidCredentials,
    UserNotFoundException() => l10n.errorGeneric,
    ProductNotFoundException() => l10n.scanErrorNotFound,
    ProductAlreadyTakenException(:final productName) =>
      l10n.actionErrorAlreadyTaken(productName),
    NotBorrowerException(:final productName) => l10n.actionErrorNotYours(
      productName,
    ),
    PermissionDeniedException() => l10n.permissionDeniedCreate,
  };
}

extension UserRoleL10n on UserRole {
  String label(AppLocalizations l10n) => switch (this) {
    UserRole.admin => l10n.roleAdmin,
    UserRole.employee => l10n.roleEmployee,
  };
}

extension ProductStatusL10n on ProductStatus {
  String label(AppLocalizations l10n) => switch (this) {
    ProductStatus.available => l10n.statusAvailable,
    ProductStatus.taken => l10n.statusTaken,
  };
}

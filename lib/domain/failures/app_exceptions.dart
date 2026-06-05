sealed class AppException implements Exception {
  const AppException();
}

final class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException();
}

final class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException();
}

final class UserNotFoundException extends AppException {
  const UserNotFoundException();
}

final class ProductNotFoundException extends AppException {
  const ProductNotFoundException();
}

final class ProductAlreadyTakenException extends AppException {
  const ProductAlreadyTakenException(this.productName);
  final String productName;
}

final class NotBorrowerException extends AppException {
  const NotBorrowerException(this.productName);
  final String productName;
}

final class PermissionDeniedException extends AppException {
  const PermissionDeniedException();
}

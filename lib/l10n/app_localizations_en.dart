// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Warehouse';

  @override
  String get splashTagline => 'Warehouse inventory tracking';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionOk => 'OK';

  @override
  String get actionClose => 'Close';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get loading => 'Loading…';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Welcome back to the warehouse';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerSubtitle => 'Join the warehouse team';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldConfirmPassword => 'Confirm password';

  @override
  String get buttonSignIn => 'Sign in';

  @override
  String get buttonSignUp => 'Sign up';

  @override
  String get linkNoAccount => 'No account? Sign up';

  @override
  String get linkHaveAccount => 'Already have an account? Sign in';

  @override
  String get validationEmailRequired => 'Enter your email';

  @override
  String get validationEmailInvalid => 'Enter a valid email';

  @override
  String get validationPasswordRequired => 'Enter your password';

  @override
  String validationPasswordTooShort(int count) {
    return 'Password must be at least $count characters';
  }

  @override
  String get validationNameRequired => 'Enter your name';

  @override
  String get validationConfirmMismatch => 'Passwords do not match';

  @override
  String get errorInvalidCredentials => 'Invalid email or password';

  @override
  String get errorEmailTaken => 'This email is already registered';

  @override
  String demoAdminHint(String email, String password) {
    return 'Demo admin: $email / $password';
  }

  @override
  String get navCatalog => 'Catalog';

  @override
  String get navScan => 'Scan';

  @override
  String get navProfile => 'Profile';

  @override
  String get catalogTitle => 'Products';

  @override
  String get catalogSearchHint => 'Search products';

  @override
  String get catalogEmpty => 'No products yet';

  @override
  String get catalogEmptyAdmin => 'Tap + to add the first product';

  @override
  String get catalogEmployeeEmpty =>
      'Products added by an administrator will appear here';

  @override
  String get filterAll => 'All';

  @override
  String get filterAvailable => 'Available';

  @override
  String get filterTaken => 'Taken';

  @override
  String get statusAvailable => 'Available';

  @override
  String get statusTaken => 'Taken';

  @override
  String get productDetailTitle => 'Product';

  @override
  String get sectionDescription => 'Description';

  @override
  String get sectionStatus => 'Status';

  @override
  String get sectionBorrowInfo => 'Borrow info';

  @override
  String get sectionHistory => 'History';

  @override
  String get noDescription => 'No description provided';

  @override
  String takenBy(String name) {
    return 'Taken by $name';
  }

  @override
  String takenAt(String date) {
    return 'Taken on $date';
  }

  @override
  String get historyEmpty => 'No actions recorded yet';

  @override
  String historyTook(String name) {
    return '$name took the item';
  }

  @override
  String historyReturned(String name) {
    return '$name returned the item';
  }

  @override
  String get buttonShowQr => 'Show QR code';

  @override
  String get buttonTake => 'Take';

  @override
  String get buttonReturn => 'Return';

  @override
  String get addProductTitle => 'Add product';

  @override
  String get addProductName => 'Product name';

  @override
  String get addProductDescription => 'Description';

  @override
  String get addProductImage => 'Product photo';

  @override
  String get addProductPickCamera => 'Camera';

  @override
  String get addProductPickGallery => 'Gallery';

  @override
  String get addProductRemoveImage => 'Remove photo';

  @override
  String get addProductImageHint =>
      'Add a photo so the item is easy to recognize';

  @override
  String get validationProductNameRequired => 'Enter a product name';

  @override
  String get productCreated => 'Product created';

  @override
  String get buttonCreateProduct => 'Create product';

  @override
  String get qrTitle => 'Product QR code';

  @override
  String get qrHint => 'Scan this code to take or return the item';

  @override
  String get qrProductId => 'Product ID';

  @override
  String get buttonShare => 'Share';

  @override
  String get scanTitle => 'Scan QR code';

  @override
  String get scanHint => 'Point the camera at a product QR code';

  @override
  String get scanTorch => 'Torch';

  @override
  String get scanFlip => 'Flip camera';

  @override
  String get scanErrorNoCamera => 'No camera available on this device';

  @override
  String get scanErrorPermission =>
      'Camera permission is required to scan QR codes';

  @override
  String get scanErrorInvalid => 'This QR code is not a valid product code';

  @override
  String get scanErrorEmpty => 'The QR code is empty';

  @override
  String get scanErrorNotFound => 'Product not found in the warehouse';

  @override
  String get buttonOpenSettings => 'Open settings';

  @override
  String get buttonGrantPermission => 'Grant permission';

  @override
  String actionResultTaken(String name) {
    return 'You took \"$name\"';
  }

  @override
  String actionResultReturned(String name) {
    return 'You returned \"$name\"';
  }

  @override
  String actionErrorAlreadyTaken(String name) {
    return '\"$name\" is already taken by someone else';
  }

  @override
  String actionErrorNotYours(String name) {
    return '\"$name\" was taken by another user, so you can\'t return it';
  }

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleEmployee => 'Employee';

  @override
  String get permissionDeniedCreate => 'Only administrators can add products';

  @override
  String get usersTitle => 'Users';

  @override
  String get usersEmpty => 'No users';

  @override
  String get youLabel => 'You';

  @override
  String get changeRole => 'Change role';

  @override
  String get roleChanged => 'Role updated';

  @override
  String registeredOn(String date) {
    return 'Registered $date';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeMode => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get settingsManageUsers => 'Manage users';

  @override
  String get settingsSeedData => 'Generate test products';

  @override
  String seedDataDone(int count) {
    return 'Added $count test products';
  }

  @override
  String get settingsMyBorrowed => 'Items I borrowed';

  @override
  String get myBorrowedEmpty => 'You haven\'t taken any items';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Log out of your account?';

  @override
  String greeting(String name) {
    return 'Hello, $name';
  }
}

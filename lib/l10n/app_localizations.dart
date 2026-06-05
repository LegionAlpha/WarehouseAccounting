import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// Application name shown on the launcher and app bars
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get appTitle;

  /// Subtitle shown under the app name on the splash screen
  ///
  /// In en, this message translates to:
  /// **'Warehouse inventory tracking'**
  String get splashTagline;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get actionOk;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to the warehouse'**
  String get loginSubtitle;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join the warehouse team'**
  String get registerSubtitle;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get fieldConfirmPassword;

  /// No description provided for @buttonSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get buttonSignIn;

  /// No description provided for @buttonSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get buttonSignUp;

  /// No description provided for @linkNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account? Sign up'**
  String get linkNoAccount;

  /// No description provided for @linkHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get linkHaveAccount;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {count} characters'**
  String validationPasswordTooShort(int count);

  /// No description provided for @validationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get validationNameRequired;

  /// No description provided for @validationConfirmMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationConfirmMismatch;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get errorInvalidCredentials;

  /// No description provided for @errorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get errorEmailTaken;

  /// No description provided for @demoAdminHint.
  ///
  /// In en, this message translates to:
  /// **'Demo admin: {email} / {password}'**
  String demoAdminHint(String email, String password);

  /// No description provided for @navCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get navCatalog;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get catalogTitle;

  /// No description provided for @catalogSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get catalogSearchHint;

  /// No description provided for @catalogEmpty.
  ///
  /// In en, this message translates to:
  /// **'No products yet'**
  String get catalogEmpty;

  /// No description provided for @catalogEmptyAdmin.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add the first product'**
  String get catalogEmptyAdmin;

  /// No description provided for @catalogEmployeeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Products added by an administrator will appear here'**
  String get catalogEmployeeEmpty;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get filterAvailable;

  /// No description provided for @filterTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get filterTaken;

  /// No description provided for @statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get statusAvailable;

  /// No description provided for @statusTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get statusTaken;

  /// No description provided for @productDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productDetailTitle;

  /// No description provided for @sectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get sectionDescription;

  /// No description provided for @sectionStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get sectionStatus;

  /// No description provided for @sectionBorrowInfo.
  ///
  /// In en, this message translates to:
  /// **'Borrow info'**
  String get sectionBorrowInfo;

  /// No description provided for @sectionHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get sectionHistory;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description provided'**
  String get noDescription;

  /// No description provided for @takenBy.
  ///
  /// In en, this message translates to:
  /// **'Taken by {name}'**
  String takenBy(String name);

  /// No description provided for @takenAt.
  ///
  /// In en, this message translates to:
  /// **'Taken on {date}'**
  String takenAt(String date);

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No actions recorded yet'**
  String get historyEmpty;

  /// No description provided for @historyTook.
  ///
  /// In en, this message translates to:
  /// **'{name} took the item'**
  String historyTook(String name);

  /// No description provided for @historyReturned.
  ///
  /// In en, this message translates to:
  /// **'{name} returned the item'**
  String historyReturned(String name);

  /// No description provided for @buttonShowQr.
  ///
  /// In en, this message translates to:
  /// **'Show QR code'**
  String get buttonShowQr;

  /// No description provided for @buttonTake.
  ///
  /// In en, this message translates to:
  /// **'Take'**
  String get buttonTake;

  /// No description provided for @buttonReturn.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get buttonReturn;

  /// No description provided for @addProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get addProductTitle;

  /// No description provided for @addProductName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get addProductName;

  /// No description provided for @addProductDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get addProductDescription;

  /// No description provided for @addProductImage.
  ///
  /// In en, this message translates to:
  /// **'Product photo'**
  String get addProductImage;

  /// No description provided for @addProductPickCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get addProductPickCamera;

  /// No description provided for @addProductPickGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get addProductPickGallery;

  /// No description provided for @addProductRemoveImage.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get addProductRemoveImage;

  /// No description provided for @addProductImageHint.
  ///
  /// In en, this message translates to:
  /// **'Add a photo so the item is easy to recognize'**
  String get addProductImageHint;

  /// No description provided for @validationProductNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a product name'**
  String get validationProductNameRequired;

  /// No description provided for @productCreated.
  ///
  /// In en, this message translates to:
  /// **'Product created'**
  String get productCreated;

  /// No description provided for @buttonCreateProduct.
  ///
  /// In en, this message translates to:
  /// **'Create product'**
  String get buttonCreateProduct;

  /// No description provided for @qrTitle.
  ///
  /// In en, this message translates to:
  /// **'Product QR code'**
  String get qrTitle;

  /// No description provided for @qrHint.
  ///
  /// In en, this message translates to:
  /// **'Scan this code to take or return the item'**
  String get qrHint;

  /// No description provided for @qrProductId.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get qrProductId;

  /// No description provided for @buttonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get buttonShare;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanTitle;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a product QR code'**
  String get scanHint;

  /// No description provided for @scanTorch.
  ///
  /// In en, this message translates to:
  /// **'Torch'**
  String get scanTorch;

  /// No description provided for @scanFlip.
  ///
  /// In en, this message translates to:
  /// **'Flip camera'**
  String get scanFlip;

  /// No description provided for @scanErrorNoCamera.
  ///
  /// In en, this message translates to:
  /// **'No camera available on this device'**
  String get scanErrorNoCamera;

  /// No description provided for @scanErrorPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan QR codes'**
  String get scanErrorPermission;

  /// No description provided for @scanErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'This QR code is not a valid product code'**
  String get scanErrorInvalid;

  /// No description provided for @scanErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'The QR code is empty'**
  String get scanErrorEmpty;

  /// No description provided for @scanErrorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found in the warehouse'**
  String get scanErrorNotFound;

  /// No description provided for @buttonOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get buttonOpenSettings;

  /// No description provided for @buttonGrantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission'**
  String get buttonGrantPermission;

  /// No description provided for @actionResultTaken.
  ///
  /// In en, this message translates to:
  /// **'You took \"{name}\"'**
  String actionResultTaken(String name);

  /// No description provided for @actionResultReturned.
  ///
  /// In en, this message translates to:
  /// **'You returned \"{name}\"'**
  String actionResultReturned(String name);

  /// No description provided for @actionErrorAlreadyTaken.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" is already taken by someone else'**
  String actionErrorAlreadyTaken(String name);

  /// No description provided for @actionErrorNotYours.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" was taken by another user, so you can\'t return it'**
  String actionErrorNotYours(String name);

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get roleAdmin;

  /// No description provided for @roleEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get roleEmployee;

  /// No description provided for @permissionDeniedCreate.
  ///
  /// In en, this message translates to:
  /// **'Only administrators can add products'**
  String get permissionDeniedCreate;

  /// No description provided for @usersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersTitle;

  /// No description provided for @usersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No users'**
  String get usersEmpty;

  /// No description provided for @youLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get youLabel;

  /// No description provided for @changeRole.
  ///
  /// In en, this message translates to:
  /// **'Change role'**
  String get changeRole;

  /// No description provided for @roleChanged.
  ///
  /// In en, this message translates to:
  /// **'Role updated'**
  String get roleChanged;

  /// No description provided for @registeredOn.
  ///
  /// In en, this message translates to:
  /// **'Registered {date}'**
  String registeredOn(String date);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @settingsManageUsers.
  ///
  /// In en, this message translates to:
  /// **'Manage users'**
  String get settingsManageUsers;

  /// No description provided for @settingsSeedData.
  ///
  /// In en, this message translates to:
  /// **'Generate test products'**
  String get settingsSeedData;

  /// No description provided for @seedDataDone.
  ///
  /// In en, this message translates to:
  /// **'Added {count} test products'**
  String seedDataDone(int count);

  /// No description provided for @settingsMyBorrowed.
  ///
  /// In en, this message translates to:
  /// **'Items I borrowed'**
  String get settingsMyBorrowed;

  /// No description provided for @myBorrowedEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t taken any items'**
  String get myBorrowedEmpty;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Log out of your account?'**
  String get logoutConfirm;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String greeting(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

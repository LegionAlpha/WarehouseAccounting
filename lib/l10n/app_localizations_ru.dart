// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Складской учёт';

  @override
  String get splashTagline => 'Учёт товаров на складе';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get actionDelete => 'Удалить';

  @override
  String get actionEdit => 'Изменить';

  @override
  String get actionRetry => 'Повторить';

  @override
  String get actionOk => 'ОК';

  @override
  String get actionClose => 'Закрыть';

  @override
  String get actionContinue => 'Продолжить';

  @override
  String get actionConfirm => 'Подтвердить';

  @override
  String get loading => 'Загрузка…';

  @override
  String get errorGeneric => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get fieldRequired => 'Обязательное поле';

  @override
  String get loginTitle => 'Вход';

  @override
  String get loginSubtitle => 'С возвращением на склад';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get registerSubtitle => 'Присоединяйтесь к команде склада';

  @override
  String get fieldName => 'Имя';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Пароль';

  @override
  String get fieldConfirmPassword => 'Повторите пароль';

  @override
  String get buttonSignIn => 'Войти';

  @override
  String get buttonSignUp => 'Зарегистрироваться';

  @override
  String get linkNoAccount => 'Нет аккаунта? Зарегистрируйтесь';

  @override
  String get linkHaveAccount => 'Уже есть аккаунт? Войдите';

  @override
  String get validationEmailRequired => 'Введите email';

  @override
  String get validationEmailInvalid => 'Введите корректный email';

  @override
  String get validationPasswordRequired => 'Введите пароль';

  @override
  String validationPasswordTooShort(int count) {
    return 'Пароль должен содержать минимум $count символов';
  }

  @override
  String get validationNameRequired => 'Введите имя';

  @override
  String get validationConfirmMismatch => 'Пароли не совпадают';

  @override
  String get errorInvalidCredentials => 'Неверный email или пароль';

  @override
  String get errorEmailTaken => 'Этот email уже зарегистрирован';

  @override
  String demoAdminHint(String email, String password) {
    return 'Демо-админ: $email / $password';
  }

  @override
  String get navCatalog => 'Каталог';

  @override
  String get navScan => 'Сканировать';

  @override
  String get navProfile => 'Профиль';

  @override
  String get catalogTitle => 'Товары';

  @override
  String get catalogSearchHint => 'Поиск товаров';

  @override
  String get catalogEmpty => 'Товаров пока нет';

  @override
  String get catalogEmptyAdmin => 'Нажмите +, чтобы добавить первый товар';

  @override
  String get catalogEmployeeEmpty =>
      'Здесь появятся товары, добавленные администратором';

  @override
  String get filterAll => 'Все';

  @override
  String get filterAvailable => 'Свободные';

  @override
  String get filterTaken => 'Занятые';

  @override
  String get statusAvailable => 'Свободен';

  @override
  String get statusTaken => 'Занят';

  @override
  String get productDetailTitle => 'Товар';

  @override
  String get sectionDescription => 'Описание';

  @override
  String get sectionStatus => 'Статус';

  @override
  String get sectionBorrowInfo => 'Информация о выдаче';

  @override
  String get sectionHistory => 'История';

  @override
  String get noDescription => 'Описание не указано';

  @override
  String takenBy(String name) {
    return 'Взял: $name';
  }

  @override
  String takenAt(String date) {
    return 'Взят $date';
  }

  @override
  String get historyEmpty => 'Действий пока нет';

  @override
  String historyTook(String name) {
    return '$name взял(а) товар';
  }

  @override
  String historyReturned(String name) {
    return '$name вернул(а) товар';
  }

  @override
  String get buttonShowQr => 'Показать QR-код';

  @override
  String get buttonTake => 'Взять';

  @override
  String get buttonReturn => 'Вернуть';

  @override
  String get addProductTitle => 'Добавить товар';

  @override
  String get addProductName => 'Название товара';

  @override
  String get addProductDescription => 'Описание';

  @override
  String get addProductImage => 'Фото товара';

  @override
  String get addProductPickCamera => 'Камера';

  @override
  String get addProductPickGallery => 'Галерея';

  @override
  String get addProductRemoveImage => 'Удалить фото';

  @override
  String get addProductImageHint =>
      'Добавьте фото, чтобы товар было легко узнать';

  @override
  String get validationProductNameRequired => 'Введите название товара';

  @override
  String get productCreated => 'Товар создан';

  @override
  String get buttonCreateProduct => 'Создать товар';

  @override
  String get qrTitle => 'QR-код товара';

  @override
  String get qrHint => 'Отсканируйте этот код, чтобы взять или вернуть товар';

  @override
  String get qrProductId => 'ID товара';

  @override
  String get buttonShare => 'Поделиться';

  @override
  String get scanTitle => 'Сканировать QR-код';

  @override
  String get scanHint => 'Наведите камеру на QR-код товара';

  @override
  String get scanTorch => 'Фонарик';

  @override
  String get scanFlip => 'Сменить камеру';

  @override
  String get scanErrorNoCamera => 'На устройстве нет доступной камеры';

  @override
  String get scanErrorPermission => 'Для сканирования нужен доступ к камере';

  @override
  String get scanErrorInvalid =>
      'Этот QR-код не является корректным кодом товара';

  @override
  String get scanErrorEmpty => 'QR-код пустой';

  @override
  String get scanErrorNotFound => 'Товар не найден на складе';

  @override
  String get buttonOpenSettings => 'Открыть настройки';

  @override
  String get buttonGrantPermission => 'Разрешить доступ';

  @override
  String actionResultTaken(String name) {
    return 'Вы взяли «$name»';
  }

  @override
  String actionResultReturned(String name) {
    return 'Вы вернули «$name»';
  }

  @override
  String actionErrorAlreadyTaken(String name) {
    return '«$name» уже занят другим пользователем';
  }

  @override
  String actionErrorNotYours(String name) {
    return '«$name» взял другой пользователь, вы не можете вернуть его';
  }

  @override
  String get roleAdmin => 'Администратор';

  @override
  String get roleEmployee => 'Сотрудник';

  @override
  String get permissionDeniedCreate =>
      'Только администраторы могут добавлять товары';

  @override
  String get usersTitle => 'Пользователи';

  @override
  String get usersEmpty => 'Пользователей нет';

  @override
  String get youLabel => 'Вы';

  @override
  String get changeRole => 'Сменить роль';

  @override
  String get roleChanged => 'Роль обновлена';

  @override
  String registeredOn(String date) {
    return 'Зарегистрирован $date';
  }

  @override
  String get profileTitle => 'Профиль';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppearance => 'Оформление';

  @override
  String get settingsThemeMode => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settingsManageUsers => 'Управление пользователями';

  @override
  String get settingsSeedData => 'Сгенерировать тестовые товары';

  @override
  String seedDataDone(int count) {
    return 'Добавлено товаров: $count';
  }

  @override
  String get settingsMyBorrowed => 'Взятые мной товары';

  @override
  String get myBorrowedEmpty => 'Вы не брали товаров';

  @override
  String get logout => 'Выйти';

  @override
  String get logoutConfirm => 'Выйти из аккаунта?';

  @override
  String greeting(String name) {
    return 'Здравствуйте, $name';
  }
}

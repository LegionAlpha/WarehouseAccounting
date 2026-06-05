import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/core/settings/app_settings.dart';

class SettingsController extends Notifier<AppSettings> {
  static const String _themeKey = 'settings_theme_mode';
  static const String _localeKey = 'settings_locale';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() {
    final themeName = _prefs.getString(_themeKey);
    final localeCode = _prefs.getString(_localeKey);
    return AppSettings(
      themeMode: _themeFromName(themeName),
      locale: (localeCode == null || localeCode.isEmpty)
          ? null
          : Locale(localeCode),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setString(_themeKey, mode.name);
  }

  Future<void> setLocale(Locale? locale) async {
    state = state.copyWith(locale: locale);
    if (locale == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, locale.languageCode);
    }
  }

  ThemeMode _themeFromName(String? name) => ThemeMode.values.firstWhere(
    (mode) => mode.name == name,
    orElse: () => ThemeMode.system,
  );
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

import 'package:flutter/material.dart';

@immutable
class AppSettings {
  const AppSettings({required this.themeMode, required this.locale});

  final ThemeMode themeMode;
  final Locale? locale;

  static const Object _unset = Object();

  AppSettings copyWith({ThemeMode? themeMode, Object? locale = _unset}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: identical(locale, _unset) ? this.locale : locale as Locale?,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.themeMode == themeMode &&
      other.locale == locale;

  @override
  int get hashCode => Object.hash(themeMode, locale);
}

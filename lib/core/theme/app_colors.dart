import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color brandIndigo = Color(0xFF4F46E5);
  static const Color brandIndigoLight = Color(0xFF6366F1);
  static const Color brandIndigoDark = Color(0xFF4338CA);
  static const List<Color> brandGradient = <Color>[
    brandIndigoLight,
    brandIndigo,
    brandIndigoDark,
  ];

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x33000000);

  static const Color availableBackgroundLight = Color(0xFFD7F2DD);
  static const Color availableForegroundLight = Color(0xFF14632B);
  static const Color availableBackgroundDark = Color(0xFF173A23);
  static const Color availableForegroundDark = Color(0xFF7FE0A0);
  static const Color takenBackgroundLight = Color(0xFFFCE5D6);
  static const Color takenForegroundLight = Color(0xFF8A4B12);
  static const Color takenBackgroundDark = Color(0xFF3A2917);
  static const Color takenForegroundDark = Color(0xFFF2B488);
}

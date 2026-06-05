import 'package:flutter/material.dart';

extension DateFormatting on BuildContext {
  String formatDate(DateTime value) {
    return MaterialLocalizations.of(this).formatMediumDate(value);
  }

  String formatDateTime(DateTime value) {
    final material = MaterialLocalizations.of(this);
    final use24h = MediaQuery.maybeOf(this)?.alwaysUse24HourFormat ?? true;
    final date = material.formatMediumDate(value);
    final time = material.formatTimeOfDay(
      TimeOfDay.fromDateTime(value),
      alwaysUse24HourFormat: use24h,
    );
    return '$date · $time';
  }
}

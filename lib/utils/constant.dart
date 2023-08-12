import 'dart:convert';

import 'package:intl/intl.dart';

// Utilities
const String locale = 'id_ID';

extension DateTimeExtension on DateTime {
  String dayName() => DateFormat("E", locale).format(this);
  String simpleDate() => DateFormat("yyyy-MM-dd", locale).format(this);
  String fullDate() => DateFormat("d MMM yyyy", locale).format(this);
  String fullDateTime() =>
      DateFormat("E, d MMM yyyy HH:mm", locale).format(this);
  String dateTime() => DateFormat("yyyy-MM-dd HH:mm:ss", locale).format(this);
  String getTime() => DateFormat('HH:mm', locale).format(this);
  String getHour() => DateFormat('HH', locale).format(this);
  String getMinute() => DateFormat('mm', locale).format(this);
}

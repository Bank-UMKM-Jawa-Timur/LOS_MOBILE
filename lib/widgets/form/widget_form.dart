import 'package:flutter/material.dart';
import 'package:los_mobile/widgets/colors/theme.dart';

class WidgetForm {
  static const focusedBorderWidget = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(width: 1, color: WidgetTheme.borderForm),
  );
  static const enabledBorderWidget = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 1, color: WidgetTheme.borderForm),
  );
}

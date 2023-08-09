import 'package:flutter/material.dart';

class WidgetShadow {
  shadowCard() {
    return const BoxShadow(
      color: Color(0xFFDCDDFF),
      blurRadius: 4,
      offset: Offset(0, 1), // Shadow position
    );
  }
}

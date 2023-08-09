import 'package:flutter/material.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';

legendChart(String title, Color legendColor) {
  return Row(
    children: [
      Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(
          color: legendColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      spaceWidthVerySmall,
      Text(
        title,
        style: textBoldDarkSmall,
      )
    ],
  );
}

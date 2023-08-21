import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:los_mobile/utils/colors.dart';

Widget emptyChart() {
  return DChartPie(
    data: const [
      {'domain': 'data', 'measure': 1},
    ],
    fillColor: (pieData, index) {
      switch (pieData['domain']) {
        default:
          return mGreyVeryLightColor;
      }
    },
    donutWidth: 32,
    labelColor: Colors.transparent,
    labelPosition: PieLabelPosition.auto,
  );
}

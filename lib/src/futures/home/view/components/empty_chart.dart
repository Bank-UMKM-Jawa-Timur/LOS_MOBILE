import 'package:flutter/material.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

DoughnutSeries emptyChartDougnut() {
  return DoughnutSeries<_CatChartData, String>(
    animationDuration: 1000,
    dataSource: [
      _CatChartData('nol', 1, mGreyVeryLightColor),
    ],
    radius: '70%',
    explode: false,
    xValueMapper: (_CatChartData data, _) => data.category,
    yValueMapper: (_CatChartData data, _) => data.total,
    pointColorMapper: (_CatChartData data, _) => data.color,
  );
}

class _CatChartData {
  _CatChartData(this.category, this.total, this.color);

  final String category;
  final num total;
  final Color color;
}

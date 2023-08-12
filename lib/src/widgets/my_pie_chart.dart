import 'package:flutter/material.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:pie_chart/pie_chart.dart';

pieChart(BuildContext context, Map<String, double> dataMap,
    List<Color> colorList, String total) {
  return PieChart(
    dataMap: dataMap,
    animationDuration: const Duration(milliseconds: 1000),
    chartLegendSpacing: 30,
    chartRadius: MediaQuery.of(context).size.width / 3.2,
    colorList: colorList,
    initialAngleInDegree: 0,
    chartType: ChartType.ring,
    emptyColor: mGreyVeryLightColor,
    ringStrokeWidth: 32,
    centerText: total,
    centerTextStyle: const TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    legendOptions: const LegendOptions(
      showLegendsInRow: true,
      legendPosition: LegendPosition.bottom,
      showLegends: false,
      legendTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
    ),
    chartValuesOptions: const ChartValuesOptions(
      showChartValueBackground: true,
      chartValueBackgroundColor: Color(0xFFF8F8F8),
      chartValueStyle: textBoldDarkMedium,
      showChartValues: true,
      showChartValuesInPercentage: false,
      showChartValuesOutside: true,
      decimalPlaces: 0,
    ),
  );
}

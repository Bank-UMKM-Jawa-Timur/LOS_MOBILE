import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/components/empty_chart.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget componentPosisiPengajuan2(
  String total,
  int pincab,
  int pbp,
  int pbo,
  int penyelia,
  int staff,
  bool isMobile,
) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: const [
        shadowMedium,
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 20),
          child: Text(
            "Diproses",
            style: textBoldDarkLarge,
          ),
        ),
        SizedBox(
          width: Get.width,
          height: 230,
          child: Center(
            child: SfCircularChart(
              margin: const EdgeInsets.all(0),
              annotations: [
                CircularChartAnnotation(
                  widget: SizedBox(
                    child: Text(
                      total,
                      style: textColorBoldDarkSmall(25, Colors.black),
                    ),
                  ),
                )
              ],
              series: [
                if (pincab == 0 &&
                    pbp == 0 &&
                    pbo == 0 &&
                    penyelia == 0 &&
                    staff == 0)
                  emptyChartDougnut()
                else
                  DoughnutSeries<_CatChartData, String>(
                    animationDuration: 1000,
                    dataSource: [
                      _CatChartData('Pincab', pincab, mBlueFlatColor),
                      _CatChartData('PBP', pbp, mAmberFlatColor),
                      _CatChartData('PBO', pbo, mPurpleLightColor),
                      _CatChartData('Penyelia', penyelia, mPinkLightColor),
                      _CatChartData('Staf', staff, mBlueLightColor),
                    ],
                    radius: '70%',
                    explode: false,
                    xValueMapper: (_CatChartData data, _) => data.category,
                    yValueMapper: (_CatChartData data, _) => data.total,
                    pointColorMapper: (_CatChartData data, _) => data.color,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      builder: (dynamic data, dynamic point, dynamic series,
                          int pointIndex, int seriesIndex) {
                        return Text(
                          data.category + '\n' + "${data.total}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black),
                        );
                      },
                      connectorLineSettings: const ConnectorLineSettings(
                          type: ConnectorType.line,
                          length: "10",
                          width: 1.5,
                          color: Colors.black),
                      showZeroValue: false,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _CatChartData {
  _CatChartData(this.category, this.total, this.color);

  final String category;
  final num total;
  final Color color;
}

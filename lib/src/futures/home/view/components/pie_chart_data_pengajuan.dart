import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/components/empty_chart.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

Widget componentDataPengajuan2(
  String total,
  int disetujui,
  int ditolak,
  int diproses,
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
            "Data Pengajuan",
            style: textBoldDarkLarge,
          ),
        ),
        AspectRatio(
          aspectRatio: 15 / 9,
          child: Stack(
            children: [
              if (disetujui == 0 && ditolak == 0 && diproses == 0)
                emptyChart()
              else
                DChartPie(
                  data: [
                    {'domain': 'Disetujui', 'measure': disetujui},
                    {'domain': 'Ditolak', 'measure': ditolak},
                    {'domain': 'Diproses', 'measure': diproses},
                  ],
                  fillColor: (pieData, index) {
                    switch (pieData['domain']) {
                      case 'Disetujui':
                        return mGreenFlatColor;
                      case 'Ditolak':
                        return mPrimaryColor;
                      default:
                        return mYellowColor;
                    }
                  },
                  donutWidth: 32,
                  labelLineThickness: 1.5,
                  labelColor: Colors.black,
                  labelFontSize: 9,
                  strokeWidth: 0,
                  labelLinelength: 15,
                  labelLineColor: mPrimaryColor,
                  pieLabel: (pieData, index) {
                    return "${pieData['domain']}\n${pieData['measure']}";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              Align(
                child: Text(
                  total,
                  style: textColorBoldDarkSmall(30, Colors.black),
                ),
              ),
            ],
          ),
        ),
        spaceHeightMedium,
      ],
    ),
  );
}

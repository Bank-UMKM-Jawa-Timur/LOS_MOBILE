import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/components/empty_chart.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

Widget componentSkemaKreditWithNameSkema2(
  String total,
  int pincab,
  int pbp,
  int pbo,
  int penyelia,
  int staf,
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
            "Proses Skema Kredit",
            style: textBoldDarkLarge,
          ),
        ),
        AspectRatio(
          aspectRatio: 15 / 9,
          child: Stack(
            children: [
              if (pincab == 0 &&
                  pbp == 0 &&
                  pbo == 0 &&
                  penyelia == 0 &&
                  staf == 0)
                emptyChart()
              else
                DChartPie(
                  data: [
                    {'domain': 'Pincab', 'measure': pincab},
                    {'domain': 'PBP', 'measure': pbp},
                    {'domain': 'PBO', 'measure': pbo},
                    {'domain': 'Penyelia', 'measure': penyelia},
                    {'domain': 'Staf', 'measure': staf},
                  ],
                  labelLinelength: 20,
                  fillColor: (pieData, index) {
                    if (pieData['measure'] == 0) {
                      return Colors
                          .grey; // Gunakan warna abu-abu jika nilai measure adalah 0
                    }
                    switch (pieData['domain']) {
                      case 'Pincab':
                        return mBlueFlatColor;
                      case 'PBP':
                        return mAmberFlatColor;
                      case 'PBO':
                        return mPurpleLightColor;
                      case 'Penyelia':
                        return mPinkLightColor;
                      default:
                        return mBlueLightColor;
                    }
                  },
                  labelLineThickness: 1.5,
                  donutWidth: 32,
                  labelColor: Colors.black,
                  strokeWidth: 0,
                  labelFontSize: 9,
                  labelLineColor: mPrimaryColor,
                  pieLabel: (pieData, index) {
                    return "${pieData['domain']}\n${pieData['measure']}";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              Align(
                child: Text(
                  total,
                  style: textColorBoldDarkSmall(25, Colors.black),
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

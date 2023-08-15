import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
import 'package:los_mobile/src/widgets/my_pie_chart.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

final colorListPosisi = <Color>[
  mBlueFlatColor,
  mAmberFlatColor,
  mPurpleLightColor,
  mPinkLightColor,
  mBlueLightColor,
];

Container componentPosisiPengajuan(
  BuildContext context,
  String total,
  double pincab,
  double pbp,
  double pbo,
  double penyelia,
  double staff,
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
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Diproses",
            style: textBoldDarkLarge,
          ),
          spaceHeightLarge,
          pieChart(
            context,
            {
              "Pincab": pincab,
              "PBP": pbp,
              "PBO": pbo,
              "Penyelia": penyelia,
              "Staff": staff,
            },
            colorListPosisi,
            total,
          ),
          spaceHeightSmall,
          spaceHeightMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart("Pincab", mBlueFlatColor),
              legendChart("PBP", mAmberFlatColor),
              legendChart("PBO", mPurpleLightColor),
              legendChart("Penyelia", mPinkLightColor),
              legendChart("Staff", mBlueLightColor),
            ],
          ),
        ],
      ),
    ),
  );
}

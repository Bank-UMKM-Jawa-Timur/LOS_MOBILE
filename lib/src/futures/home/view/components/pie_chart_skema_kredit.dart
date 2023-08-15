import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
import 'package:los_mobile/src/widgets/my_pie_chart.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

final colorListSkema = <Color>[
  mPurpleDarkColor,
  mYellowFlatColor,
  mGreenDarkColor,
  mPrimaryColor,
  mBlueDarkFlatColor,
];

Container componentSkemaKreditWithoutNameSkema(
  BuildContext context,
  String total,
  double pkpj,
  double kkb,
  double umroh,
  double prokesra,
  double kusuma,
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
            "Skema Kredit",
            style: textBoldDarkLarge,
          ),
          spaceHeightLarge,
          pieChart(
            context,
            {
              "PKPJ": pkpj,
              "KKB": kkb,
              "Umroh": umroh,
              "Prokesra": prokesra,
              "Kusuma": kusuma,
            },
            colorListSkema,
            total,
          ),
          spaceHeightSmall,
          spaceHeightMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart("PKPJ", mPurpleDarkColor),
              legendChart("KKB", mYellowFlatColor),
              legendChart("Umroh", mGreenDarkColor),
              legendChart("Prokesra", mPrimaryColor),
              legendChart("Kusuma", mBlueDarkFlatColor),
            ],
          ),
        ],
      ),
    ),
  );
}

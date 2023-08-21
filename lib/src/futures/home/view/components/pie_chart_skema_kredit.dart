import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/components/empty_chart.dart';
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

Widget componentSkemaKreditWithoutNameSkema2(
  String total,
  int pkpj,
  int kkb,
  int umroh,
  int prokesra,
  int kusuma,
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
              if (pkpj == 0 &&
                  kkb == 0 &&
                  umroh == 0 &&
                  prokesra == 0 &&
                  kusuma == 0)
                emptyChart()
              else
                DChartPie(
                  data: [
                    {'domain': 'PKPJ', 'measure': pkpj},
                    {'domain': 'KKB', 'measure': kkb},
                    {'domain': 'Umroh', 'measure': umroh},
                    {'domain': 'Prokesra', 'measure': prokesra},
                    {'domain': 'Kusuma', 'measure': kusuma},
                  ],
                  labelLinelength: 14,
                  fillColor: (pieData, index) {
                    if (pieData['measure'] == 0) {
                      return Colors
                          .grey; // Gunakan warna abu-abu jika nilai measure adalah 0
                    }
                    switch (pieData['domain']) {
                      case 'PKPJ':
                        return mPurpleDarkColor;
                      case 'KKB':
                        return mYellowFlatColor;
                      case 'Umroh':
                        return mGreenDarkColor;
                      case 'Prokesra':
                        return mPrimaryColor;
                      default:
                        return mBlueDarkFlatColor;
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
import 'package:los_mobile/src/widgets/my_pie_chart.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

final colorListData = <Color>[
  mGreenFlatColor,
  mPrimaryColor,
  mYellowColor,
];

Container componentDataPengajuan(
  BuildContext context,
  String total,
  double disetujui,
  double ditolak,
  double diproses,
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
      child: GetBuilder<DataPengajuanController>(
        init: DataPengajuanController(),
        initState: (_) {},
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Data Pengajuan",
                style: textBoldDarkLarge,
              ),
              spaceHeightLarge,
              pieChart(
                context,
                {
                  'Disetujui': disetujui,
                  'Ditolak': ditolak,
                  'Diproses': diproses,
                },
                colorListData,
                total,
              ),
              spaceHeightSmall,
              spaceHeightMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  legendChart("Disetujui", mGreenFlatColor),
                  legendChart("Ditolak", mPrimaryColor),
                  legendChart("Diproses", mYellowColor),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}

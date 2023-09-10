import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_data_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_ranking/export_ranking_skema_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_ranking/export_rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_skema_kredit_controller.dart';
import 'package:los_mobile/src/futures/home/view/excel/posisi_pengajuan/table_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/excel/semua_skema_dan_semua_cabang.dart/table_skema_cabang.dart';
import 'package:los_mobile/src/futures/home/view/excel/skema_with_name/table_skema_with_name.dart';
import 'package:los_mobile/src/futures/home/view/pdf/export_pdf.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/date/my_date_picker_android.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_target_platform.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/utils/constant.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  var dataCabangController = Get.put(ExportDataCabangController());
  var dataPengajuanController = Get.put(ExportDataPengajuanController());
  var ratingCabangController = Get.put(ExportRatingCabangController());
  var posisiPengajuanController = Get.put(ExportPosisiPengajuanController());
  var skemaKreditController = Get.put(ExportSkemaKreditController());
  var rankingSkemaController = Get.put(ExportRankingSkemaController());
  String? valueExportData;
  List<dynamic> exportData = [
    'PDF',
    'Excel',
  ];

  List<dynamic> listSkema = [
    '-- pilih semua --',
    'PKPJ',
    'KKB',
    'Umroh',
    'Prokesra',
    'Kusuma',
  ];
  String? valueCodeCabang;
  String? valueCabang;
  String? valueSkemaKredit;

  Future reset() async {
    if (mounted) {
      setState(() {
        valueCodeCabang = null;
        valueCabang = null;
        valueSkemaKredit = null;
        skemaKreditController.valueSkemaKredit = null;
        dataCabangController.selectKodeCabang.value = "";
        dataCabangController.selectCabang.value = "Semua cabang";
      });
    }
  }

  Future refreshAndFilter() async {
    Get.find<ExportSkemaKreditController>();
    dataCabangController.selectKodeCabang.value = valueCodeCabang == null
        ? dataCabangController.selectKodeCabang.value
        : valueCodeCabang!;
    dataCabangController.selectCabang.value =
        valueCabang == null ? "Semua cabang" : valueCabang!;
    skemaKreditController.valueSkemaKredit =
        valueSkemaKredit == null || valueSkemaKredit == "-- pilih semua --"
            ? null
            : valueSkemaKredit;

    // Skema kredit tanpa nama
    skemaKreditController.totalSkema.value = 0;
    skemaKreditController.totalSkemaPkpj.value = 0;
    skemaKreditController.totalSkemaKkb.value = 0;
    skemaKreditController.totalSkemaUmroh.value = 0;
    skemaKreditController.totalSkemaProkesra.value = 0;
    skemaKreditController.totalSkemaKusuma.value = 0;
    // Skema Kredit dengan nama
    skemaKreditController.totalProsesSkema.value = 0;
    skemaKreditController.totalPengajuanSkema.value = 0;
    skemaKreditController.totalSkemaDisetujui.value = 0;
    skemaKreditController.totalSkemaDitolak.value = 0;
    skemaKreditController.skemaPosisiPincab.value = 0;
    skemaKreditController.skemaPosisiPbp.value = 0;
    skemaKreditController.skemaPosisiPbo.value = 0;
    skemaKreditController.skemaPosisiPenyelia.value = 0;
    skemaKreditController.skemaPosisiStaf.value = 0;
    // data pengajuan
    dataPengajuanController.totalPengajuan.value = 0;
    dataPengajuanController.totalDisetujui.value = 0;
    dataPengajuanController.totalDitolak.value = 0;
    dataPengajuanController.totalDiproses.value = 0;
    dataPengajuanController.getDataPengajuan();
    dataCabangController.selectKodeCabang.value.isEmpty
        ? null
        : posisiPengajuanController.getPosisiPengajuan();
    // posisiPengajuanController.getPosisiPengajuan();
    dataCabangController.selectKodeCabang.value.isEmpty
        ? ratingCabangController.getDataRating()
        : null;
    skemaKreditController.getSkemaKredit();
    skemaKreditController.valueSkemaKredit == null
        ? null
        : rankingSkemaController.getRankingSkema();
    dataCabangController.typeFilter.value = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        backgroundColor: mPrimaryColor,
        elevation: 3,
        title: Text(
          "Export Data Nomitanatif",
          style: textColorBoldDarkSmall(16, Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            _formDate(context),
            _formSkemaKredit(),
            Obx(() => dataCabangController.isLoading.value
                ? _formCabang()
                : _formCabang()),
            _formExport(),
            spaceHeightMedium,
            _bottomExport(),
          ],
        ),
      ),
    );
  }

  SizedBox _formDate(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: GridView.count(
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal awal",
                  style: textBoldDarkMedium,
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (defaultTargetPlatform == deviceAndroid) {
                      final date = await datePicker(context, DateTime.now());
                      if (mounted) {
                        setState(() {
                          ratingCabangController.firstDateFilter = date!;
                        });
                      }
                    } else if (defaultTargetPlatform == deviceIos) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                          height: 400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        ratingCabangController.firstDateFilter =
                                            val;
                                      });
                                    }),
                              ),
                              // Close the modal
                              CupertinoButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: decorationFormTgl(),
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 21,
                                color: mPrimaryColor,
                              ),
                              spaceWidthVerySmall,
                              Text(
                                ratingCabangController.firstDateFilter
                                    .simpleDate(),
                                style: textBoldDarkMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal akhir",
                  style: textBoldDarkMedium,
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (defaultTargetPlatform == deviceAndroid) {
                      final date = await datePicker(context, DateTime.now());
                      if (mounted) {
                        setState(() {
                          ratingCabangController.lastDateFilter = date!;
                        });
                      }
                    } else if (defaultTargetPlatform == deviceIos) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                          height: 400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        ratingCabangController.lastDateFilter =
                                            val;
                                      });
                                    }),
                              ),

                              // Close the modal
                              CupertinoButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: decorationFormTgl(),
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 21,
                                color: mPrimaryColor,
                              ),
                              spaceWidthVerySmall,
                              Text(
                                ratingCabangController.lastDateFilter
                                    .simpleDate()
                                    .toString(),
                                style: textBoldDarkMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _formSkemaKredit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Skema kredit", style: textBoldDarkMedium),
        const SizedBox(height: 5),
        SizedBox(
          height: 35,
          child: DropdownButtonFormField(
            isDense: true,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            // value: skemaKreditController.valueSkemaKredit,
            value: valueSkemaKredit,
            hint: Text(
                // skemaKreditController.valueSkemaKredit == null
                //     ? "-- pilih semua --"
                //     : skemaKreditController.valueSkemaKredit!,
                "-- pilih semua --",
                style: textBoldDarkMedium),
            onChanged: ((value) {
              if (mounted) {
                setState(() {
                  valueSkemaKredit = value as String?;
                });
              }
            }),
            items: listSkema.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item,
                  style: textBoldDarkMedium,
                ),
                value: item,
              );
            }).toList(),
          ),
        ),
        spaceHeightSmall,
      ],
    );
  }

  Column _formCabang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cabang", style: textBoldDarkMedium),
        const SizedBox(height: 5),
        SizedBox(
          height: 35,
          child: DropdownButtonFormField(
            isDense: true,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            value: valueCodeCabang,
            hint: Text(dataCabangController.selectCabang.value,
                style: textBoldDarkMedium),
            onChanged: ((value) {
              if (mounted) {
                valueCodeCabang = value!;
              }
            }),
            items: dataCabangController.dataCabangModel?.data.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.cabang,
                  style: textBoldDarkMedium,
                ),
                onTap: () {
                  valueCabang = item.cabang;
                },
                value: item.kodeCabang,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column _formExport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceHeightMedium,
        const Text("Export", style: textBoldDarkMedium),
        const SizedBox(height: 5),
        SizedBox(
          height: 35,
          child: DropdownButtonFormField(
            isDense: true,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            value: valueExportData,
            hint: const Text("PDF", style: textBoldDarkMedium),
            onChanged: ((value) {
              valueExportData = value as String?;
              print(valueExportData);
            }),
            items: exportData.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item,
                  style: textBoldDarkMedium,
                ),
                value: item,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  SizedBox _bottomExport() {
    return SizedBox(
        width: Get.width,
        child: Obx(
          () => dataPengajuanController.isLoading.value
              ? _bottomLoading()
              : ratingCabangController.isLoading.value
                  ? _bottomLoading()
                  : dataCabangController.isLoading.value
                      ? _bottomLoading()
                      : posisiPengajuanController.isLoading.value
                          ? _bottomLoading()
                          : skemaKreditController.isLoading.value
                              ? _bottomLoading()
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: mPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () {
                                          refreshAndFilter();
                                          Timer(const Duration(seconds: 2), () {
                                            if (valueExportData == null ||
                                                valueExportData == "PDF") {
                                              ExportPdf().printPdf();
                                            } else {
                                              if (dataCabangController
                                                  .selectKodeCabang
                                                  .isNotEmpty) {
                                                if (skemaKreditController
                                                        .valueSkemaKredit ==
                                                    null) {
                                                  ExportPosisiPengajuan()
                                                      .excelPosisiPengajuan(); //kesalahan
                                                } else {
                                                  ExportSkemaWithName()
                                                      .excelSkemaWithName();
                                                }
                                              } else {
                                                if (skemaKreditController
                                                        .valueSkemaKredit ==
                                                    null) {
                                                  ExportSemuaSkemaDanSemuaCabang()
                                                      .excelSemuaSkemaDanSemuaCabang();
                                                } else {
                                                  ExportSkemaWithName()
                                                      .excelSkemaWithName();
                                                }
                                              }
                                            }
                                          });
                                        },
                                        child: const Text(
                                          "EXPORT",
                                          style: textBoldLightMedium,
                                        ),
                                      ),
                                    ),
                                    if (dataCabangController
                                            .selectCabang.value ==
                                        "Semua cabang")
                                      Container()
                                    else
                                      spaceWidthSmall,
                                    if (dataCabangController
                                            .selectCabang.value ==
                                        "Semua cabang")
                                      Container()
                                    else
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFFFE5E4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // <-- Radius
                                            ),
                                          ),
                                          onPressed: () {
                                            reset();
                                          },
                                          child: const Text(
                                            "Reset",
                                            style:
                                                TextStyle(color: mPrimaryColor),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
        ));
  }

  Widget _bottomLoading() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // <-- Radius
        ),
      ),
      onPressed: null,
      child: const Text(
        "Loading...",
        style: textBoldLightMedium,
      ),
    );
  }
}

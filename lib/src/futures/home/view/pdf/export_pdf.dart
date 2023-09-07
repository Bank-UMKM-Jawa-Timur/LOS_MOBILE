import 'dart:io';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/ranking/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/skema_kredit_controller.dart';
import 'package:los_mobile/src/futures/home/view/pdf/data_pengajuan/grand_total_data_pengajua.dart';
import 'package:los_mobile/src/futures/home/view/pdf/data_pengajuan/header_main_data_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/data_pengajuan/second_header_data_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/data_pengajuan/value_table_data_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/posisi_pengajuan/grand_total_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/posisi_pengajuan/header_main_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/posisi_pengajuan/second_header_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/posisi_pengajuan/value_table_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_with_name/grand_total_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_with_name/header_main_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_with_name/second_header_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_with_name/value_table_sekama.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_without_name/grand_total_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_without_name/header_main_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_without_name/second_header_skema.dart';
import 'package:los_mobile/src/futures/home/view/pdf/skema_without_name/value_table_sekama.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportPdf {
  var dataPengajuanC = Get.find<DataPengajuanController>();
  var posisiPengajuanC = Get.find<PosisiPengajuanController>();
  var skemaKreditC = Get.find<SkemaKreditController>();
  var cabangC = Get.find<DataCabangController>();
  var ratingCabangC = Get.find<RatingCabangController>();

  void printPdf() async {
    final pdf = pw.Document();
    final primaryColor = PdfColor.fromHex('#EE2649');
    final spaceHeightLarge = pw.SizedBox(height: 15);
    final spaceHeightMedium = pw.SizedBox(height: 10);
    final title = "DATA NOMINATIF";

    pdf.addPage(
      pw.MultiPage(build: (context) {
        return [
          pw.Column(children: [
            pw.Center(
              child: pw.Text(
                title,
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
              ),
            ),
            spaceHeightMedium,
            pw.Center(
              child: pw.Text(
                "Data Pengajuan, ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} Tanggal: ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}",
                style: pw.TextStyle(fontSize: 12),
              ),
            ),

            // Posisi Pengajuan
            cabangC.selectKodeCabang.isNotEmpty
                ? skemaKreditC.valueSkemaKredit != null
                    ? pw.Container()
                    : pw.Column(children: [
                        spaceHeightLarge,
                        headerMainPosisiPengajuan(),
                        secondHeaderPosisiPengajuan(),
                        pw.ListView.builder(
                          itemCount: posisiPengajuanC
                              .posisiPengajuanModel!.data.length,
                          itemBuilder: (context, index) {
                            return valueTablePosisiPengajuan(
                              context,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].kodeC,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].cabang,
                              // Mengambil dari data pengajuan
                              int.parse(dataPengajuanC.dataPengajuanModel!
                                  .data[index].totalDisetujui),
                              int.parse(dataPengajuanC.dataPengajuanModel!
                                  .data[index].totalDitolak),
                              // end
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].pincab,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].pbp,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].pbo,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].penyelia,
                              posisiPengajuanC
                                  .posisiPengajuanModel!.data[index].staff,
                              int.parse(dataPengajuanC.dataPengajuanModel!
                                      .data[index].totalDisetujui) +
                                  int.parse(dataPengajuanC.dataPengajuanModel!
                                      .data[index].totalDitolak) +
                                  posisiPengajuanC.posisiPengajuanModel!
                                      .data[index].pincab +
                                  posisiPengajuanC
                                      .posisiPengajuanModel!.data[index].pbp +
                                  posisiPengajuanC
                                      .posisiPengajuanModel!.data[index].pbo +
                                  posisiPengajuanC.posisiPengajuanModel!
                                      .data[index].penyelia +
                                  posisiPengajuanC
                                      .posisiPengajuanModel!.data[index].staff,
                            );
                          },
                        ),
                        grandPosisiPengajuan(
                          dataPengajuanC.totalDisetujui.value,
                          dataPengajuanC.totalDitolak.value,
                          posisiPengajuanC.totalPosisiPincab.value,
                          posisiPengajuanC.totalPosisiPbp.value,
                          posisiPengajuanC.totalPosisiPbo.value,
                          posisiPengajuanC.totalPosisiPenyelia.value,
                          posisiPengajuanC.totalPosisiStaf.value,
                          dataPengajuanC.totalDisetujui.value +
                              dataPengajuanC.totalDitolak.value +
                              posisiPengajuanC.totalPosisiPincab.value +
                              posisiPengajuanC.totalPosisiPbp.value +
                              posisiPengajuanC.totalPosisiPbo.value +
                              posisiPengajuanC.totalPosisiPenyelia.value +
                              posisiPengajuanC.totalPosisiStaf.value,
                        ),
                      ])
                : pw.Container(),
            // ===== end posisi pengajuan =======

            // Data Pengajuan
            skemaKreditC.valueSkemaKredit != null
                ? pw.Container()
                : pw.Column(children: [
                    spaceHeightLarge,
                    headerMainDataPengajuan(),
                    secondHeaderDataPengajuan(),
                    pw.ListView.builder(
                      itemCount: dataPengajuanC.dataPengajuanModel!.data.length,
                      itemBuilder: (context, index) {
                        return valueTableDataPengajuan(
                          context,
                          dataPengajuanC.dataPengajuanModel!.data[index].kodeC,
                          dataPengajuanC.dataPengajuanModel!.data[index].cabang,
                          dataPengajuanC
                              .dataPengajuanModel!.data[index].totalDisetujui,
                          dataPengajuanC
                              .dataPengajuanModel!.data[index].totalDitolak,
                          dataPengajuanC
                              .dataPengajuanModel!.data[index].totalDiproses,
                          int.parse(dataPengajuanC.dataPengajuanModel!
                                  .data[index].totalDisetujui) +
                              int.parse(dataPengajuanC.dataPengajuanModel!
                                  .data[index].totalDitolak) +
                              int.parse(dataPengajuanC.dataPengajuanModel!
                                  .data[index].totalDiproses),
                        );
                      },
                    ),
                    grandDataPengajuan(
                        dataPengajuanC.totalDisetujui.value,
                        dataPengajuanC.totalDitolak.value,
                        dataPengajuanC.totalDiproses.value,
                        dataPengajuanC.totalPengajuan.value),
                  ]),
            // ===== end data pengajuan =======

            if (skemaKreditC.valueSkemaKredit != null)
              // Skema with name
              pw.Column(children: [
                spaceHeightLarge,
                headerMainSkemaWithName(),
                secondHeaderSkemaWithName(),
                pw.ListView.builder(
                  itemCount: skemaKreditC.lengthSkemaWithName.value,
                  itemBuilder: (context, index) {
                    return skemaKreditC.lengthSkemaWithName.value > 1
                        ? valueTableSkemaWithName(
                            context,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].kodeCabang,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].cabang,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].totalDisetujui,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].totalDitolak,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].posisiPincab,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].posisiPbp,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].posisiPbo,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].posisiPenyelia,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].posisiStaf,
                            skemaKreditC.skemaKreditWithNameSkemaModel!
                                .data[index].total,
                          )
                        : valueTableSkemaWithName(
                            context,
                            cabangC.selectKodeCabang.value,
                            cabangC.selectCabang.value,
                            skemaKreditC.totalSkemaDisetujui.value.toString(),
                            skemaKreditC.totalSkemaDitolak.value.toString(),
                            skemaKreditC.skemaPosisiPincab.value.toString(),
                            skemaKreditC.skemaPosisiPbp.value.toString(),
                            skemaKreditC.skemaPosisiPbo.value.toString(),
                            skemaKreditC.skemaPosisiPenyelia.value.toString(),
                            skemaKreditC.skemaPosisiStaf.value.toString(),
                            skemaKreditC.totalPengajuanSkema.value,
                          );
                  },
                ),
                grandSkemaWithName(
                  skemaKreditC.totalSkemaDisetujui.value,
                  skemaKreditC.totalSkemaDitolak.value,
                  skemaKreditC.skemaPosisiPincab.value,
                  skemaKreditC.skemaPosisiPbp.value,
                  skemaKreditC.skemaPosisiPbo.value,
                  skemaKreditC.skemaPosisiPenyelia.value,
                  skemaKreditC.skemaPosisiStaf.value,
                  skemaKreditC.totalPengajuanSkema.value,
                ),
              ])
            // ===== end skema with name =======
            else
              // skema without name
              pw.Column(children: [
                spaceHeightLarge,
                headerMainSkemaWithoutName(),
                secondHeaderSkemaWithoutName(),
                pw.ListView.builder(
                    itemCount: skemaKreditC.lengthSkemaWithoutName.value,
                    itemBuilder: (context, index) {
                      return valueTableSkemaWithoutName(
                        context,
                        skemaKreditC.skemaKreditModel!.data[index].kodeCabang,
                        skemaKreditC.skemaKreditModel!.data[index].cabang,
                        skemaKreditC.skemaKreditModel!.data[index].pkpj,
                        skemaKreditC.skemaKreditModel!.data[index].kkb,
                        skemaKreditC.skemaKreditModel!.data[index].umroh,
                        skemaKreditC.skemaKreditModel!.data[index].prokesra,
                        skemaKreditC.skemaKreditModel!.data[index].kusuma,
                        int.parse(skemaKreditC
                                .skemaKreditModel!.data[index].pkpj) +
                            int.parse(skemaKreditC
                                .skemaKreditModel!.data[index].kkb) +
                            int.parse(skemaKreditC
                                .skemaKreditModel!.data[index].umroh) +
                            int.parse(skemaKreditC
                                .skemaKreditModel!.data[index].prokesra) +
                            int.parse(skemaKreditC
                                .skemaKreditModel!.data[index].kusuma),
                      );
                    }),
                grandSkemaWithoutName(
                  skemaKreditC.totalSkemaPkpj.value,
                  skemaKreditC.totalSkemaKkb.value,
                  skemaKreditC.totalSkemaUmroh.value,
                  skemaKreditC.totalSkemaProkesra.value,
                  skemaKreditC.totalSkemaKusuma.value,
                  skemaKreditC.totalSkema.value,
                ),
              ]),
            // ===== end skema without name =======
          ])
        ];
      }),
    );

    // Get a writable directory for saving the PDF
    final output = await getTemporaryDirectory();
    final filePath1 =
        '${output.path}/Kategori berdasarkan ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} tanggal ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}.pdf';
    final file = File(filePath1);
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    // if (generate == false) {
    // String pdfFilePath = await filePath1;
    // sharePDF(pdfFilePath);
    // } else {
    // await OpenFile.open(file.path);
    // }
  }

  // void sharePDF(String filePath) {
  //   Share.shareFiles([filePath], text: 'Sharing PDF');
  // }
}

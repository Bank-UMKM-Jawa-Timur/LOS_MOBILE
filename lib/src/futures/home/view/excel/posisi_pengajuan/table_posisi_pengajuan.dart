import 'dart:io';

import 'package:get/get.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_data_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_ranking/export_rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_skema_kredit_controller.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportPosisiPengajuan {
  var dataPengajuanC = Get.find<ExportDataPengajuanController>();
  var posisiPengajuanC = Get.find<ExportPosisiPengajuanController>();
  var skemaKreditC = Get.find<ExportSkemaKreditController>();
  var cabangC = Get.find<ExportDataCabangController>();
  var ratingCabangC = Get.find<ExportRatingCabangController>();

  void excelPosisiPengajuan() async {
    final Workbook workbook = Workbook(1);
    final Worksheet sheet = workbook.worksheets[0];
    int indexPosisiPengajuan = 0;
    int indexSkema = 0;

    Style styleGrand = workbook.styles.add('style1');
    Style styleValue = workbook.styles.add('style2');
    styleGrand.fontColor = '#000000';
    styleGrand.bold = true;
    styleGrand.borders.all.color = '#000000';
    styleGrand.borders.all.lineStyle = LineStyle.thin;
    styleValue.borders.all.color = '#000000';
    styleValue.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('A1').setText(
        'DATA NOMINATIF\nSkema Kredit, ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} Tanggal: ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}');

    // Second Header & posisi pengajuan
    Style globalStyle = workbook.styles.add('style');
    Style globalStyle1 = workbook.styles.add('style3');
    globalStyle.backColor = '#EE2649';
    globalStyle.fontColor = '#FFFFFF';
    globalStyle.bold = true;
    globalStyle.borders.all.color = '#000000';
    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle1.borders.all.color = '#000000';
    globalStyle1.borders.all.lineStyle = LineStyle.thin;

    // Main Header posisi Pengajuan
    sheet.getRangeByName('A3').setText('Posisi Pengajuan');
    sheet.getRangeByName('A4').setText('Kode');
    sheet.getRangeByName('B4').setText('Cabang');
    sheet.getRangeByName('C4').setText('Disetujui');
    sheet.getRangeByName('D4').setText('Ditolak');
    sheet.getRangeByName('E4').setText('Pincab');
    sheet.getRangeByName('F4').setText('PBP');
    sheet.getRangeByName('G4').setText('PBO');
    sheet.getRangeByName('H4').setText('Penyelia');
    sheet.getRangeByName('I4').setText('Staff');
    sheet.getRangeByName('J4').setText('Total');

    sheet.getRangeByName('A3').cellStyle = globalStyle;
    sheet.getRangeByName('A4:J4').cellStyle = globalStyle1;

    final cell = sheet.getRangeByName('A1:A3');
    cell.cellStyle.hAlign = HAlignType.center;
    cell.cellStyle.vAlign = VAlignType.center;

    sheet.getRangeByIndex(1, 1).columnWidth = 15;
    sheet.getRangeByIndex(1, 2).columnWidth = 20;
    sheet.getRangeByIndex(1, 1).columnSpan = 10;
    sheet.getRangeByIndex(1, 1).rowHeight = 40;
    sheet.getRangeByIndex(3, 1).columnSpan = 10;
    sheet.getRangeByIndex(3, 1).rowHeight = 30;

    // value get data from database
    for (var i = 5;
        i < posisiPengajuanC.posisiPengajuanModel!.data.length + 5;
        i++) {
      sheet
          .getRangeByName('A$i')
          .setText(posisiPengajuanC.posisiPengajuanModel!.data[i - 5].kodeC);
      sheet
          .getRangeByName('B$i')
          .setText(posisiPengajuanC.posisiPengajuanModel!.data[i - 5].cabang);
      // Get data dari data pengajuan
      sheet.getRangeByName('C$i').setNumber(double.parse(
          dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDisetujui));
      sheet.getRangeByName('D$i').setNumber(double.parse(
          dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDitolak));
      // ####
      sheet.getRangeByName('E$i').setNumber(double.parse(posisiPengajuanC
          .posisiPengajuanModel!.data[i - 5].pincab
          .toString()));
      sheet.getRangeByName('F$i').setNumber(double.parse(
          posisiPengajuanC.posisiPengajuanModel!.data[i - 5].pbp.toString()));
      sheet.getRangeByName('G$i').setNumber(double.parse(
          posisiPengajuanC.posisiPengajuanModel!.data[i - 5].pbo.toString()));
      sheet.getRangeByName('H$i').setNumber(double.parse(posisiPengajuanC
          .posisiPengajuanModel!.data[i - 5].penyelia
          .toString()));
      sheet.getRangeByName('I$i').setNumber(double.parse(
          posisiPengajuanC.posisiPengajuanModel!.data[i - 5].staff.toString()));
      sheet.getRangeByName('J$i').setNumber(
            double.parse(dataPengajuanC
                    .dataPengajuanModel!.data[i - 5].totalDisetujui) +
                double.parse(dataPengajuanC
                    .dataPengajuanModel!.data[i - 5].totalDitolak) +
                double.parse(posisiPengajuanC
                    .posisiPengajuanModel!.data[i - 5].pincab
                    .toString()) +
                double.parse(posisiPengajuanC.posisiPengajuanModel!.data[i - 5].pbp
                    .toString()) +
                double.parse(posisiPengajuanC.posisiPengajuanModel!.data[i - 5].pbo
                    .toString()) +
                double.parse(posisiPengajuanC
                    .posisiPengajuanModel!.data[i - 5].penyelia
                    .toString()) +
                double.parse(posisiPengajuanC
                    .posisiPengajuanModel!.data[i - 5].staff
                    .toString()),
          );
      indexPosisiPengajuan = i;
      sheet.getRangeByName('A$i:J$i').cellStyle = styleValue;
    }
    indexPosisiPengajuan += 1;

    // Grand
    sheet.getRangeByName('A$indexPosisiPengajuan').setText('Grand Total');
    sheet.getRangeByName('C$indexPosisiPengajuan').setNumber(
        double.parse(dataPengajuanC.totalDisetujui.value.toString()));
    sheet
        .getRangeByName('D$indexPosisiPengajuan')
        .setNumber(double.parse(dataPengajuanC.totalDitolak.value.toString()));
    sheet.getRangeByName('E$indexPosisiPengajuan').setNumber(
        double.parse(posisiPengajuanC.totalPosisiPincab.value.toString()));
    sheet.getRangeByName('F$indexPosisiPengajuan').setNumber(
        double.parse(posisiPengajuanC.totalPosisiPbp.value.toString()));
    sheet.getRangeByName('G$indexPosisiPengajuan').setNumber(
        double.parse(posisiPengajuanC.totalPosisiPbo.value.toString()));
    sheet.getRangeByName('H$indexPosisiPengajuan').setNumber(
        double.parse(posisiPengajuanC.totalPosisiPenyelia.value.toString()));
    sheet.getRangeByName('I$indexPosisiPengajuan').setNumber(
        double.parse(posisiPengajuanC.totalPosisiStaf.value.toString()));
    sheet.getRangeByName('J$indexPosisiPengajuan').setNumber(double.parse(
            dataPengajuanC.totalDisetujui.value.toString()) +
        double.parse(dataPengajuanC.totalDitolak.value.toString()) +
        double.parse(posisiPengajuanC.totalPosisiPincab.value.toString()) +
        double.parse(posisiPengajuanC.totalPosisiPbp.value.toString()) +
        double.parse(posisiPengajuanC.totalPosisiPbo.value.toString()) +
        double.parse(posisiPengajuanC.totalPosisiPenyelia.value.toString()) +
        double.parse(posisiPengajuanC.totalPosisiStaf.value.toString()));
    sheet.getRangeByIndex(indexPosisiPengajuan, 1).columnSpan = 2;
    // sheet.deleteRow(indexPosisiPengajuan, 9);
    sheet
        .getRangeByName('A$indexPosisiPengajuan:J$indexPosisiPengajuan')
        .cellStyle = styleGrand;
    final cell2 = sheet.getRangeByName('A$indexPosisiPengajuan');
    cell2.cellStyle.hAlign = HAlignType.center;
    cell2.cellStyle.vAlign = VAlignType.center;

    // ############
    // Main Header SKEMA KREDIT
    sheet.getRangeByIndex(indexPosisiPengajuan + 2, 1).columnSpan = 8;
    sheet.getRangeByIndex(indexPosisiPengajuan + 2, 1).rowHeight = 30;
    sheet
        .getRangeByName('A${indexPosisiPengajuan + 2}')
        .setText('Total Skema Kredit');
    sheet.getRangeByName('A${indexPosisiPengajuan + 3}').setText('Kode');
    sheet.getRangeByName('B${indexPosisiPengajuan + 3}').setText('Cabang');
    sheet.getRangeByName('C${indexPosisiPengajuan + 3}').setText('PKPJ');
    sheet.getRangeByName('D${indexPosisiPengajuan + 3}').setText('KKB');
    sheet.getRangeByName('E${indexPosisiPengajuan + 3}').setText('Umroh');
    sheet.getRangeByName('F${indexPosisiPengajuan + 3}').setText('Prokesra');
    sheet.getRangeByName('G${indexPosisiPengajuan + 3}').setText('Kusuma');
    sheet.getRangeByName('H${indexPosisiPengajuan + 3}').setText('Total');

    sheet.getRangeByName('A${indexPosisiPengajuan + 2}').cellStyle =
        globalStyle;
    sheet
        .getRangeByName(
            'A${indexPosisiPengajuan + 3}:H${indexPosisiPengajuan + 3}')
        .cellStyle = globalStyle1;

    final cellSkema = sheet.getRangeByName('A${indexPosisiPengajuan + 2}');
    cellSkema.cellStyle.hAlign = HAlignType.center;
    cellSkema.cellStyle.vAlign = VAlignType.center;

    print(indexPosisiPengajuan);

    for (var i = indexPosisiPengajuan + 4;
        i <
            skemaKreditC.lengthSkemaWithoutName.value +
                indexPosisiPengajuan +
                4;
        i++) {
      sheet.getRangeByName('A$i').setText(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].kodeCabang);
      sheet.getRangeByName('B$i').setText(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].cabang);
      sheet.getRangeByName('C$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].pkpj));
      sheet.getRangeByName('D$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].kkb));
      sheet.getRangeByName('E$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].umroh));
      sheet.getRangeByName('F$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].prokesra));
      sheet.getRangeByName('G$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].kusuma));
      sheet.getRangeByName('H$i').setNumber(double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].pkpj) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].kkb) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].umroh) +
          double.parse(skemaKreditC.skemaKreditModel!
              .data[i - (indexPosisiPengajuan + 4)].prokesra) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPosisiPengajuan + 4)].kusuma));
      sheet.getRangeByName('A$i:H$i').cellStyle = styleValue;
      indexSkema = i;
    }

    indexSkema += 1;
    // Grand
    sheet.getRangeByName('A$indexSkema').setText('Grand Total');
    sheet
        .getRangeByName('C$indexSkema')
        .setNumber(double.parse(skemaKreditC.totalSkemaPkpj.value.toString()));
    sheet
        .getRangeByName('D$indexSkema')
        .setNumber(double.parse(skemaKreditC.totalSkemaKkb.value.toString()));
    sheet
        .getRangeByName('E$indexSkema')
        .setNumber(double.parse(skemaKreditC.totalSkemaUmroh.value.toString()));
    sheet.getRangeByName('F$indexSkema').setNumber(
        double.parse(skemaKreditC.totalSkemaProkesra.value.toString()));
    sheet.getRangeByName('G$indexSkema').setNumber(
        double.parse(skemaKreditC.totalSkemaKusuma.value.toString()));
    sheet
        .getRangeByName('H$indexSkema')
        .setNumber(double.parse(skemaKreditC.totalSkema.value.toString()));
    sheet.getRangeByIndex(indexSkema, 1).columnSpan = 2;
    sheet.getRangeByName('A$indexSkema:H$indexSkema').cellStyle = styleGrand;

    final cellSkema2 = sheet.getRangeByName('A$indexSkema');
    cellSkema2.cellStyle.hAlign = HAlignType.center;
    cellSkema2.cellStyle.vAlign = VAlignType.center;

    // Save the workbook to bytes.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File(
        '$path/Kategori berdasarkan ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} tanggal ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(
        '$path/Kategori berdasarkan ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} tanggal ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}.xlsx');
  }
}

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

class ExportSemuaSkemaDanSemuaCabang {
  var dataPengajuanC = Get.find<ExportDataPengajuanController>();
  var posisiPengajuanC = Get.find<ExportPosisiPengajuanController>();
  var skemaKreditC = Get.find<ExportSkemaKreditController>();
  var cabangC = Get.find<ExportDataCabangController>();
  var ratingCabangC = Get.find<ExportRatingCabangController>();

  void excelSemuaSkemaDanSemuaCabang() async {
    final Workbook workbook = Workbook(1);
    final Worksheet sheet = workbook.worksheets[0];
    int indexPengajuan = 0;
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
        'DATA NOMINATIF\nData Pengajuan, ${skemaKreditC.valueSkemaKredit == null ? "" : skemaKreditC.valueSkemaKredit} Tanggal: ${ratingCabangC.firstDateFilter.simpleDate()} sampai ${ratingCabangC.lastDateFilter.simpleDate()} ${cabangC.selectCabang}');

    // Second Header & Data pengajuan
    Style globalStyle = workbook.styles.add('style');
    Style globalStyle1 = workbook.styles.add('style3');
    globalStyle.backColor = '#EE2649';
    globalStyle.fontColor = '#FFFFFF';
    globalStyle.bold = true;
    globalStyle.borders.all.color = '#000000';
    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle1.borders.all.color = '#000000';
    globalStyle1.borders.all.lineStyle = LineStyle.thin;

    // Main Header tanpa milih skema dan tanpa cabang
    sheet
        .getRangeByName('A3')
        .setText('Total Pengajuan Selesai, ditolak dan proses');
    sheet.getRangeByName('A4').setText('Kode');
    sheet.getRangeByName('B4').setText('Cabang');
    sheet.getRangeByName('C4').setText('Disetujui');
    sheet.getRangeByName('D4').setText('Ditolak');
    sheet.getRangeByName('E4').setText('Diproses');
    sheet.getRangeByName('F4').setText('Total');

    sheet.getRangeByName('A3').cellStyle = globalStyle;
    sheet.getRangeByName('A4:F4').cellStyle = globalStyle1;

    final cell = sheet.getRangeByName('A1:A3');
    cell.cellStyle.hAlign = HAlignType.center;
    cell.cellStyle.vAlign = VAlignType.center;

    sheet.getRangeByIndex(1, 1).columnWidth = 15;
    sheet.getRangeByIndex(1, 2).columnWidth = 20;
    sheet.getRangeByIndex(1, 1).columnSpan = 6;
    sheet.getRangeByIndex(1, 1).rowHeight = 40;
    sheet.getRangeByIndex(3, 1).columnSpan = 6;
    sheet.getRangeByIndex(3, 1).rowHeight = 30;

    // value get data from database
    for (var i = 5;
        i < dataPengajuanC.dataPengajuanModel!.data.length + 5;
        i++) {
      sheet
          .getRangeByName('A$i')
          .setText(dataPengajuanC.dataPengajuanModel!.data[i - 5].kodeC);
      sheet
          .getRangeByName('B$i')
          .setText(dataPengajuanC.dataPengajuanModel!.data[i - 5].cabang);
      sheet.getRangeByName('C$i').setNumber(double.parse(
          dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDisetujui));
      sheet.getRangeByName('D$i').setNumber(double.parse(
          dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDitolak));
      sheet.getRangeByName('E$i').setNumber(double.parse(
          dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDiproses));
      sheet.getRangeByName('F$i').setNumber(double.parse(
              dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDisetujui) +
          double.parse(
              dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDitolak) +
          double.parse(
              dataPengajuanC.dataPengajuanModel!.data[i - 5].totalDiproses));
      indexPengajuan = i;
      sheet.getRangeByName('A$i:F$i').cellStyle = styleValue;
    }

    indexPengajuan += 1;
    // Grand
    sheet.getRangeByName('A$indexPengajuan').setText('Grand Total');
    sheet.getRangeByName('C$indexPengajuan').setNumber(
        double.parse(dataPengajuanC.totalDisetujui.value.toString()));
    sheet
        .getRangeByName('D$indexPengajuan')
        .setNumber(double.parse(dataPengajuanC.totalDitolak.value.toString()));
    sheet
        .getRangeByName('E$indexPengajuan')
        .setNumber(double.parse(dataPengajuanC.totalDiproses.value.toString()));
    sheet.getRangeByName('F$indexPengajuan').setNumber(
        double.parse(dataPengajuanC.totalPengajuan.value.toString()));
    sheet.getRangeByIndex(indexPengajuan, 1).columnSpan = 2;
    // sheet.deleteRow(indexPengajuan, 9);
    sheet.getRangeByName('A$indexPengajuan:F$indexPengajuan').cellStyle =
        styleGrand;
    final cell2 = sheet.getRangeByName('A$indexPengajuan');
    cell2.cellStyle.hAlign = HAlignType.center;
    cell2.cellStyle.vAlign = VAlignType.center;

    // ############
    // Main Header SKEMA KREDIT
    sheet.getRangeByIndex(indexPengajuan + 2, 1).columnSpan = 8;
    sheet.getRangeByIndex(indexPengajuan + 2, 1).rowHeight = 30;
    sheet
        .getRangeByName('A${indexPengajuan + 2}')
        .setText('Total Skema Kredit');
    sheet.getRangeByName('A${indexPengajuan + 3}').setText('Kode');
    sheet.getRangeByName('B${indexPengajuan + 3}').setText('Cabang');
    sheet.getRangeByName('C${indexPengajuan + 3}').setText('PKPJ');
    sheet.getRangeByName('D${indexPengajuan + 3}').setText('KKB');
    sheet.getRangeByName('E${indexPengajuan + 3}').setText('Umroh');
    sheet.getRangeByName('F${indexPengajuan + 3}').setText('Prokesra');
    sheet.getRangeByName('G${indexPengajuan + 3}').setText('Kusuma');
    sheet.getRangeByName('H${indexPengajuan + 3}').setText('Total');

    sheet.getRangeByName('A${indexPengajuan + 2}').cellStyle = globalStyle;
    sheet
        .getRangeByName('A${indexPengajuan + 3}:H${indexPengajuan + 3}')
        .cellStyle = globalStyle1;

    final cellSkema = sheet.getRangeByName('A${indexPengajuan + 2}');
    cellSkema.cellStyle.hAlign = HAlignType.center;
    cellSkema.cellStyle.vAlign = VAlignType.center;

    print(indexPengajuan);

    for (var i = indexPengajuan + 4;
        i < skemaKreditC.lengthSkemaWithoutName.value + indexPengajuan + 4;
        i++) {
      sheet.getRangeByName('A$i').setText(skemaKreditC
          .skemaKreditModel!.data[i - (indexPengajuan + 4)].kodeCabang);
      sheet.getRangeByName('B$i').setText(
          skemaKreditC.skemaKreditModel!.data[i - (indexPengajuan + 4)].cabang);
      sheet.getRangeByName('C$i').setNumber(double.parse(
          skemaKreditC.skemaKreditModel!.data[i - (indexPengajuan + 4)].pkpj));
      sheet.getRangeByName('D$i').setNumber(double.parse(
          skemaKreditC.skemaKreditModel!.data[i - (indexPengajuan + 4)].kkb));
      sheet.getRangeByName('E$i').setNumber(double.parse(
          skemaKreditC.skemaKreditModel!.data[i - (indexPengajuan + 4)].umroh));
      sheet.getRangeByName('F$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPengajuan + 4)].prokesra));
      sheet.getRangeByName('G$i').setNumber(double.parse(skemaKreditC
          .skemaKreditModel!.data[i - (indexPengajuan + 4)].kusuma));
      sheet.getRangeByName('H$i').setNumber(double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPengajuan + 4)].pkpj) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPengajuan + 4)].kkb) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPengajuan + 4)].umroh) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPengajuan + 4)].prokesra) +
          double.parse(skemaKreditC
              .skemaKreditModel!.data[i - (indexPengajuan + 4)].kusuma));
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

import 'dart:io';

import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/ranking/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/skema_kredit_controller.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportSkemaWithName {
  var dataPengajuanC = Get.find<DataPengajuanController>();
  var posisiPengajuanC = Get.find<PosisiPengajuanController>();
  var skemaKreditC = Get.find<SkemaKreditController>();
  var cabangC = Get.find<DataCabangController>();
  var ratingCabangC = Get.find<RatingCabangController>();

  void excelSkemaWithName() async {
    final Workbook workbook = Workbook(1);
    final Worksheet sheet = workbook.worksheets[0];
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

    // Second Header & Skema kredit with name
    Style globalStyle = workbook.styles.add('style');
    Style globalStyle1 = workbook.styles.add('style3');
    globalStyle.backColor = '#EE2649';
    globalStyle.fontColor = '#FFFFFF';
    globalStyle.bold = true;
    globalStyle.borders.all.color = '#000000';
    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle1.borders.all.color = '#000000';
    globalStyle1.borders.all.lineStyle = LineStyle.thin;

    // Main Header Skema Kredit with name
    sheet
        .getRangeByName('A3')
        .setText('Total Skema Kredit Disetujui, Ditolak dan Diproses');
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
    for (var i = 5; i < skemaKreditC.lengthSkemaWithName.value + 5; i++) {
      if (skemaKreditC.lengthSkemaWithName.value > 1) {
        sheet.getRangeByName('A$i').setText(
            skemaKreditC.skemaKreditWithNameSkemaModel!.data[i - 5].kodeCabang);
        sheet.getRangeByName('B$i').setText(
            skemaKreditC.skemaKreditWithNameSkemaModel!.data[i - 5].cabang);
        sheet.getRangeByName('C$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].totalDisetujui));
        sheet.getRangeByName('D$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].totalDitolak));
        sheet.getRangeByName('E$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].posisiPincab));
        sheet.getRangeByName('F$i').setNumber(double.parse(
            skemaKreditC.skemaKreditWithNameSkemaModel!.data[i - 5].posisiPbp));
        sheet.getRangeByName('G$i').setNumber(double.parse(
            skemaKreditC.skemaKreditWithNameSkemaModel!.data[i - 5].posisiPbo));
        sheet.getRangeByName('H$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].posisiPenyelia));
        sheet.getRangeByName('I$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].posisiStaf));
        sheet.getRangeByName('J$i').setNumber(double.parse(skemaKreditC
            .skemaKreditWithNameSkemaModel!.data[i - 5].total
            .toString()));
        indexSkema = i;
        sheet.getRangeByName('A$i:J$i').cellStyle = styleValue;
      } else {
        sheet.getRangeByName('A$i').setText(cabangC.selectKodeCabang.value);
        sheet.getRangeByName('B$i').setText(cabangC.selectCabang.value);
        sheet.getRangeByName('C$i').setNumber(
            double.parse(skemaKreditC.totalSkemaDisetujui.value.toString()));
        sheet.getRangeByName('D$i').setNumber(
            double.parse(skemaKreditC.totalSkemaDitolak.value.toString()));
        sheet.getRangeByName('E$i').setNumber(
            double.parse(skemaKreditC.skemaPosisiPincab.value.toString()));
        sheet.getRangeByName('F$i').setNumber(
            double.parse(skemaKreditC.skemaPosisiPbp.value.toString()));
        sheet.getRangeByName('G$i').setNumber(
            double.parse(skemaKreditC.skemaPosisiPbo.value.toString()));
        sheet.getRangeByName('H$i').setNumber(
            double.parse(skemaKreditC.skemaPosisiPenyelia.value.toString()));
        sheet.getRangeByName('I$i').setNumber(
            double.parse(skemaKreditC.skemaPosisiStaf.value.toString()));
        sheet.getRangeByName('J$i').setNumber(
            double.parse(skemaKreditC.totalPengajuanSkema.value.toString()));
        indexSkema = i;
        sheet.getRangeByName('A$i:J$i').cellStyle = styleValue;
      }
    }
    indexSkema += 1;

    // Grand
    sheet.getRangeByName('A$indexSkema').setText('Grand Total');
    sheet.getRangeByName('C$indexSkema').setNumber(
        double.parse(skemaKreditC.totalSkemaDisetujui.value.toString()));
    sheet.getRangeByName('D$indexSkema').setNumber(
        double.parse(skemaKreditC.totalSkemaDitolak.value.toString()));
    sheet.getRangeByName('E$indexSkema').setNumber(
        double.parse(skemaKreditC.skemaPosisiPincab.value.toString()));
    sheet
        .getRangeByName('F$indexSkema')
        .setNumber(double.parse(skemaKreditC.skemaPosisiPbp.value.toString()));
    sheet
        .getRangeByName('G$indexSkema')
        .setNumber(double.parse(skemaKreditC.skemaPosisiPbo.value.toString()));
    sheet.getRangeByName('H$indexSkema').setNumber(
        double.parse(skemaKreditC.skemaPosisiPenyelia.value.toString()));
    sheet
        .getRangeByName('I$indexSkema')
        .setNumber(double.parse(skemaKreditC.skemaPosisiStaf.value.toString()));
    sheet.getRangeByName('J$indexSkema').setNumber(
        double.parse(skemaKreditC.totalPengajuanSkema.value.toString()));
    sheet.getRangeByIndex(indexSkema, 1).columnSpan = 2;
    // sheet.deleteRow(indexSkema, 9);
    sheet.getRangeByName('A$indexSkema:J$indexSkema').cellStyle = styleGrand;
    final cell2 = sheet.getRangeByName('A$indexSkema');
    cell2.cellStyle.hAlign = HAlignType.center;
    cell2.cellStyle.vAlign = VAlignType.center;

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

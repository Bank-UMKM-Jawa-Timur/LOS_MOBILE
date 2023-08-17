import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/models/skema_kredit/skema_kredit.dart';
import 'package:los_mobile/src/futures/home/models/skema_kredit/skema_kredit_with_name_skema.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkemaKreditController extends GetxController {
  var isLoading = false.obs;
  String? valueSkemaKredit;
  SkemaKreditModel? skemaKreditModel;
  SkemaKreditWithNameSkemaModel? skemaKreditWithNameSkemaModel;
  // Skema kredit tanpa nama skema
  var totalSkema = 0.obs;
  var totalSkemaPkpj = 0.obs;
  var totalSkemaKkb = 0.obs;
  var totalSkemaUmroh = 0.obs;
  var totalSkemaProkesra = 0.obs;
  var totalSkemaKusuma = 0.obs;

  // skema kredit dengan nama skema
  var totalProsesSkema = 0.obs;
  var totalPengajuanSkema = 0.obs;
  var totalSkemaDisetujui = 0.obs;
  var totalSkemaDitolak = 0.obs;
  var skemaPosisiPincab = 0.obs;
  var skemaPosisiPbp = 0.obs;
  var skemaPosisiPbo = 0.obs;
  var skemaPosisiPenyelia = 0.obs;
  var skemaPosisiStaf = 0.obs;

  var ratingCabangC = Get.find<RatingCabangController>();
  var dataCabangC = Get.find<DataCabangController>();

  List<dynamic> listSkema = [
    '-- pilih semua --',
    'PKPJ',
    'KKB',
    'Umroh',
    'Prokesra',
    'Kusuma',
  ].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getSkemaKredit();
  }

  getSkemaKredit() async {
    await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'token':
          'gTWx1U1bVhtz9h51cRNoiluuBfsHqty5MCdXRdmWthFDo9RMhHgHIwrU9DBFVaNj',
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
          dataCabangC.selectKodeCabang.value.isEmpty
              ? valueSkemaKredit == null
                  ? '$base_url/v1/get-sum-skema?tanggal_awal=${ratingCabangC.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangC.lastDateFilter.simpleDate()}'
                  : '$base_url/v1/get-sum-skema?tanggal_awal=${ratingCabangC.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangC.lastDateFilter.simpleDate()}&skema=$valueSkemaKredit'
              : valueSkemaKredit == null
                  ? '$base_url/v1/get-sum-skema?tanggal_awal=${ratingCabangC.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangC.lastDateFilter.simpleDate()}&cabang=${dataCabangC.selectKodeCabang.value}'
                  : '$base_url/v1/get-sum-skema?tanggal_awal=${ratingCabangC.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangC.lastDateFilter.simpleDate()}&cabang=${dataCabangC.selectKodeCabang.value}&skema=$valueSkemaKredit',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // Cek Skema jika menggunakan nama Skema kredit
        if (valueSkemaKredit == null) {
          skemaKreditModel = SkemaKreditModel.fromJson(result);
          if (skemaKreditModel!.data.isNotEmpty) {
            for (var i = 0; i < skemaKreditModel!.data.length; i++) {
              totalSkemaPkpj.value += int.parse(skemaKreditModel!.data[i].pkpj);
              totalSkemaKkb.value += int.parse(skemaKreditModel!.data[i].kkb);
              totalSkemaUmroh.value +=
                  int.parse(skemaKreditModel!.data[i].umroh);
              totalSkemaProkesra.value +=
                  int.parse(skemaKreditModel!.data[i].prokesra);
              totalSkemaKusuma.value +=
                  int.parse(skemaKreditModel!.data[i].kusuma);
            }
          } else {
            totalSkemaPkpj.value = 0;
            totalSkemaKkb.value = 0;
            totalSkemaUmroh.value = 0;
            totalSkemaProkesra.value = 0;
            totalSkemaKusuma.value = 0;
            totalSkema.value = 0;
          }
          totalSkema.value = totalSkemaPkpj.value +
              totalSkemaKkb.value +
              totalSkemaUmroh.value +
              totalSkemaProkesra.value +
              totalSkemaKusuma.value;

          // JIka tidak menggunakan nama skema
        } else {
          skemaKreditWithNameSkemaModel =
              SkemaKreditWithNameSkemaModel.fromJson(result);
          if (skemaKreditWithNameSkemaModel!.data.isNotEmpty) {
            for (var i = 0;
                i < skemaKreditWithNameSkemaModel!.data.length;
                i++) {
              totalSkemaDisetujui.value += int.parse(
                  skemaKreditWithNameSkemaModel!.data[i].totalDisetujui);
              totalSkemaDitolak.value += int.parse(
                  skemaKreditWithNameSkemaModel!.data[i].totalDitolak);
              skemaPosisiPincab.value += int.parse(
                  skemaKreditWithNameSkemaModel!.data[i].posisiPincab);
              skemaPosisiPbp.value +=
                  int.parse(skemaKreditWithNameSkemaModel!.data[i].posisiPbp);
              skemaPosisiPbo.value +=
                  int.parse(skemaKreditWithNameSkemaModel!.data[i].posisiPbo);
              skemaPosisiPenyelia.value += int.parse(
                  skemaKreditWithNameSkemaModel!.data[i].posisiPenyelia);
              skemaPosisiStaf.value +=
                  int.parse(skemaKreditWithNameSkemaModel!.data[i].posisiStaf);
            }
            totalProsesSkema.value = skemaPosisiPincab.value +
                skemaPosisiPbp.value +
                skemaPosisiPbo.value +
                skemaPosisiPenyelia.value +
                skemaPosisiStaf.value;
            totalPengajuanSkema.value = totalProsesSkema.value +
                totalSkemaDisetujui.value +
                totalSkemaDitolak.value;
          } else {
            totalProsesSkema.value = 0;
            totalPengajuanSkema.value = 0;
            totalSkemaDisetujui.value = 0;
            totalSkemaDitolak.value = 0;
            skemaPosisiPincab.value = 0;
            skemaPosisiPbp.value = 0;
            skemaPosisiPbo.value = 0;
            skemaPosisiPenyelia.value = 0;
            skemaPosisiStaf.value = 0;
          }
        }
      } else {
        debugPrint('error fetching data ${response.statusCode} SKEMA KREDIT');
      }
    } catch (e) {
      print("$e SKEMA KREDIT CATCH");
    } finally {
      isLoading(false);
    }
  }
}

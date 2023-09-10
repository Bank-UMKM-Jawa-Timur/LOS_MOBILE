import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/exports/controllers/export_data_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/controllers/export_ranking/export_rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/models/export_posisi_pengajuan.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExportPosisiPengajuanController extends GetxController {
  var isLoading = false.obs;
  var totalPosisi = 0.obs;
  var totalPosisiPincab = 0.obs;
  var totalPosisiPbp = 0.obs;
  var totalPosisiPbo = 0.obs;
  var totalPosisiPenyelia = 0.obs;
  var totalPosisiStaf = 0.obs;
  var posisiPengajuanLength = 0.obs;

  // Get Controller
  PosisiPengajuanModel? posisiPengajuanModel;
  var ratingCabangController = Get.put(ExportRatingCabangController());
  var cabangC = Get.find<ExportDataCabangController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await SharedPreferences.getInstance();
    if (cabangC.selectKodeCabang.value.isNotEmpty) {
      getPosisiPengajuan();
    }
  }

  getPosisiPengajuan() async {
    await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'token': staticToken,
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
            // cabangC.selectKodeCabang.value.isNotEmpty
            '$base_url/v1/get-posisi-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}&cabang=${cabangC.selectKodeCabang.value}'
            // :
            // '$base_url/v1/get-posisi-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}',
            ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var typeData = result['data'];
        posisiPengajuanModel = PosisiPengajuanModel.fromJson(result);
        posisiPengajuanLength.value = posisiPengajuanModel!.data.length;
        print(posisiPengajuanLength.value);
        if (typeData.isEmpty) {
          totalPosisi.value = 0;
          totalPosisiPincab.value = 0;
          totalPosisiPbp.value = 0;
          totalPosisiPbo.value = 0;
          totalPosisiPenyelia.value = 0;
          totalPosisiStaf.value = 0;
        } else {
          // if (posisiPengajuanModel!.data.length != 1) {
          //   for (var i = 0; i < posisiPengajuanModel!.data.length; i++) {
          //     totalPosisi.value = posisiPengajuanModel!.data[i].pincab +
          //         posisiPengajuanModel!.data[i].pbp +
          //         posisiPengajuanModel!.data[i].pbo +
          //         posisiPengajuanModel!.data[i].penyelia +
          //         posisiPengajuanModel!.data[i].staff;
          //     totalPosisiPincab.value += posisiPengajuanModel!.data[i].pincab;
          //     totalPosisiPbp.value += posisiPengajuanModel!.data[i].pbp;
          //     totalPosisiPbo.value += posisiPengajuanModel!.data[i].pbo;
          //     totalPosisiPenyelia.value +=
          //         posisiPengajuanModel!.data[i].penyelia;
          //     totalPosisiStaf.value += posisiPengajuanModel!.data[i].staff;
          //   }
          // } else {
          totalPosisi.value = posisiPengajuanModel!.data[0].pincab +
              posisiPengajuanModel!.data[0].pbp +
              posisiPengajuanModel!.data[0].pbo +
              posisiPengajuanModel!.data[0].penyelia +
              posisiPengajuanModel!.data[0].staff;
          totalPosisiPincab.value = posisiPengajuanModel!.data[0].pincab;
          totalPosisiPbp.value = posisiPengajuanModel!.data[0].pbp;
          totalPosisiPbo.value = posisiPengajuanModel!.data[0].pbo;
          totalPosisiPenyelia.value = posisiPengajuanModel!.data[0].penyelia;
          totalPosisiStaf.value = posisiPengajuanModel!.data[0].staff;
          // }
        }
      } else {
        debugPrint('error fetching data ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error $e POSISI");
    } finally {
      Timer(const Duration(seconds: 1), () {
        isLoading(false);
      });
    }
  }
}

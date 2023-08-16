import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/models/posisi_pengajuan.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosisiPengajuanController extends GetxController {
  var isLoading = false.obs;
  var totalPosisi = 0.obs;
  var totalPosisiPincab = 0.obs;
  var totalPosisiPbp = 0.obs;
  var totalPosisiPbo = 0.obs;
  var totalPosisiPenyelia = 0.obs;
  var totalPosisiStaf = 0.obs;

  // Get Controller
  PosisiPengajuanModel? posisiPengajuanModel;
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  var cabangC = Get.find<DataCabangController>();

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
          '$base_url/v1/get-posisi-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}&cabang=${cabangC.selectKodeCabang.value}',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var typeData = result['data'];
        posisiPengajuanModel = PosisiPengajuanModel.fromJson(result);
        if (typeData.isEmpty) {
          totalPosisi.value = 0;
        } else {
          totalPosisi.value = posisiPengajuanModel!.data[0].pincab +
              posisiPengajuanModel!.data[0].pbp +
              posisiPengajuanModel!.data[0].pbo +
              posisiPengajuanModel!.data[0].penyelia +
              posisiPengajuanModel!.data[0].staff;
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

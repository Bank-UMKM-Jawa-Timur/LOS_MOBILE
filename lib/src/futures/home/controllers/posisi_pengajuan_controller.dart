import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/models/posisi_pengajuan.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosisiPengajuanController extends GetxController {
  var isLoading = false.obs;
  int? totalPosisi;

  // Get Controller
  PosisiPengajuanModel? posisiPengajuanModel;
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  DataPengajuanController dataPengajuanController =
      Get.put(DataPengajuanController());

  @override
  Future<void> onInit() async {
    super.onInit();
    getPosisiPengajuan();
  }

  getPosisiPengajuan() async {
    await SharedPreferences.getInstance();
    // print("object ${dataPengajuanController.kodeCabang}");
    var headers = {
      'Content-Type': 'application/json',
      'token': staticToken,
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
          '$base_url/v1/get-posisi-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}&cabang=${dataPengajuanController.kodeCabang}',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var typeData = result['data'];
        posisiPengajuanModel = PosisiPengajuanModel.fromJson(result);
        if (typeData.isEmpty) {
          debugPrint("Kosong");
        } else {
          totalPosisi = typeData[0]['pincab'] +
              typeData[0]['pbp'] +
              typeData[0]['pbo'] +
              typeData[0]['penyelia'] +
              typeData[0]['staff'];
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

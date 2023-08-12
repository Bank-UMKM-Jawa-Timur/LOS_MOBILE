import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/models/data_pengajuan.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPengajuanController extends GetxController {
  var isLoading = false.obs;
  DataPengajuanModel? dataPengajuanModel;
  var totalPengajuan;
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  PreferensUser preferensUser = Get.put(PreferensUser());
  String? kodeCabang;

  @override
  Future<void> onInit() async {
    super.onInit();
    await SharedPreferences.getInstance();
    kodeCabang = preferensUser.kodeCabang;
    getDataPengajuan();
  }

  getDataPengajuan() async {
    var headers = {
      'Content-Type': 'application/json',
      'token':
          'gTWx1U1bVhtz9h51cRNoiluuBfsHqty5MCdXRdmWthFDo9RMhHgHIwrU9DBFVaNj',
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
          kodeCabang == null || kodeCabang == "null"
              ? '$base_url/v1/get-count-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}'
              : '$base_url/v1/get-count-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}&cabang=$kodeCabang',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        dataPengajuanModel = DataPengajuanModel.fromJson(result);
        totalPengajuan = result['total_disetujui'] +
            result['total_ditolak'] +
            result['total_diproses'];
      } else {
        debugPrint('error fetching data ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error $e");
    } finally {
      isLoading(false);
    }
  }
}

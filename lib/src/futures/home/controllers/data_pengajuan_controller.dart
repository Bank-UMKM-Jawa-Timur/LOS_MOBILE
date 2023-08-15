import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/models/data_pengajuan.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/home/models/rating_cabang.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPengajuanController extends GetxController {
  // GET Controller
  DataPengajuanModel? dataPengajuanModel;
  RatingCabangModel? ratingCabangModel;
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  var cabangC = Get.find<DataCabangController>();
  PreferensUser preferensUser = Get.put(PreferensUser());

  var isLoading = false.obs;
  var totalPengajuan = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await SharedPreferences.getInstance();
    cabangC.selectKodeCabang.value =
        preferensUser.kodeCabang == null ? "" : preferensUser.kodeCabang!;
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
          cabangC.selectKodeCabang.value.isEmpty
              ? '$base_url/v1/get-sum-cabang?tanggal_awal=${ratingCabangController.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangController.lastDateFilter.simpleDate()}'
              : '$base_url/v1/get-count-pengajuan?tAwal=${ratingCabangController.firstDateFilter.simpleDate()}&tAkhir=${ratingCabangController.lastDateFilter.simpleDate()}&cabang=${cabangC.selectKodeCabang.value}',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (cabangC.selectKodeCabang.value.isEmpty) {
          ratingCabangModel = RatingCabangModel.fromJson(result);
          totalPengajuan.value = result['total_disetujui'] +
              result['total_ditolak'] +
              result['total_diproses'];
        } else {
          dataPengajuanModel = DataPengajuanModel.fromJson(result);
          List<dynamic> data = result['data'];
          if (data.isNotEmpty) {
            totalPengajuan.value = int.parse("${data[0]['total_disetujui']}") +
                int.parse("${data[0]['total_ditolak']}") +
                int.parse("${data[0]['total_diproses']}");
          } else {
            totalPengajuan.value = 0;
          }
        }
      } else {
        debugPrint('error fetching data ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error $e PENGAJUAN");
    } finally {
      isLoading(false);
    }
  }
}

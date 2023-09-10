import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/exports/controllers/export_data_cabang_controller.dart';
import 'package:los_mobile/src/futures/exports/models/export_rating_cabang.dart';
import 'package:los_mobile/src/futures/exports/models/export_skema_kredit/export_skema_kredit_with_name_skema.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';

class ExportRatingCabangController extends GetxController {
  var isLoading = false.obs;
  RatingCabangModel? ratingCabangModel;
  SkemaKreditWithNameSkemaModel? skemaKreditWithNameSkemaModel;
  DateTime firstDateFilter =
      DateTime(DateTime.now().year, DateTime.now().month, 01);
  DateTime lastDateFilter =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var cabangC = Get.find<ExportDataCabangController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    if (cabangC.selectKodeCabang.value.isEmpty) {
      getDataRating();
    }
  }

  getDataRating() async {
    var headers = {
      'Content-Type': 'application/json',
      'token':
          'gTWx1U1bVhtz9h51cRNoiluuBfsHqty5MCdXRdmWthFDo9RMhHgHIwrU9DBFVaNj',
    };
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
            '$base_url/v1/get-sum-cabang?tanggal_awal=${firstDateFilter.simpleDate()}&tanggal_akhir=${lastDateFilter.simpleDate()}'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ratingCabangModel = RatingCabangModel.fromJson(result);
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

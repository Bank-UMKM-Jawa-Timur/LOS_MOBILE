import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/models/rating_cabang.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';

class RatingCabangController extends GetxController {
  var isLoading = false.obs;
  RatingCabangModel? ratingCabangModel;
  //
  DateTime firstDateFilter =
      DateTime(DateTime.now().year, DateTime.now().month, 01);
  DateTime lastDateFilter =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Future<void> onInit() async {
    super.onInit();
    getDataRating();
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
          '$base_url/v1/get-sum-cabang?tanggal_awal=${firstDateFilter.simpleDate()}&tanggal_akhir=${lastDateFilter.simpleDate()}',
        ),
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

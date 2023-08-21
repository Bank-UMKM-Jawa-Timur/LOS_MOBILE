import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/ranking/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/skema_kredit_controller.dart';
import 'package:los_mobile/src/futures/home/models/skema_kredit/skema_kredit_with_name_skema.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/constant.dart';

class RankingSkemaController extends GetxController {
  SkemaKreditWithNameSkemaModel? skemaKreditWithNameSkemaModel;
  var skemaC = Get.find<SkemaKreditController>();
  var ratingCabangC = Get.put(RatingCabangController());
  var cabangC = Get.find<DataCabangController>();
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (cabangC.selectKodeCabang.value.isEmpty) {
      getRankingSkema();
    }
  }

  getRankingSkema() async {
    var headers = {
      'Content-Type': 'application/json',
      'token':
          'gTWx1U1bVhtz9h51cRNoiluuBfsHqty5MCdXRdmWthFDo9RMhHgHIwrU9DBFVaNj',
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse(
          '$base_url/v1/get-sum-skema?tanggal_awal=${ratingCabangC.firstDateFilter.simpleDate()}&tanggal_akhir=${ratingCabangC.lastDateFilter.simpleDate()}&skema=${skemaC.valueSkemaKredit}',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        skemaKreditWithNameSkemaModel =
            SkemaKreditWithNameSkemaModel.fromJson(result);
      }
    } catch (e) {
      print("$e Ranking Skema Kredit");
    } finally {
      isLoading(false);
    }
  }
}

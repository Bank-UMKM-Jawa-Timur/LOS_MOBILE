import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/models/data_cabang.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/utils/base_url.dart';
import 'package:los_mobile/utils/token.dart';

class DataCabangController extends GetxController {
  var isLoading = false.obs;
  DataCabangModel? dataCabangModel;
  var selectCabang = "Semua cabang".obs;
  var selectKodeCabang = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getDataCabang();
  }

  getDataCabang() async {
    var headers = {
      'Content-Type': 'application/json',
      'token': staticToken,
    };

    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse('$base_url/v1/get-cabang'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        dataCabangModel = DataCabangModel.fromJson(result);
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

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:los_mobile/src/futures/login/models/cek_session_model.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CekSessionLogin extends GetxController {
  CekSessionModel? cekSessionModel;
  var isLoading = false.obs;
  int? idUser;

  @override
  Future<void> onInit() async {
    var prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("id_user") == null ? null : prefs.getInt("id_user");
    super.onInit();
    if (idUser != null) {
      cekSession();
    }
  }

  Future<void> cekSession() async {
    print(idUser);
    var headers = {'Content-Type': 'application/json'};
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse("$base_url/get-session-check/$idUser"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        cekSessionModel = CekSessionModel.fromJson(result);
      } else {
        print("${response.statusCode} CEK SESSION");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}

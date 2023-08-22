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
  var statusSession = "".obs;
  var result;

  @override
  Future<void> onInit() async {
    var prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("id_user") == null ? null : prefs.getInt("id_user");
    if (idUser != null) {
      cekSession();
    }
    super.onInit();
  }

  Future<void> cekSession() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.parse("$base_url/get-session-check/$idUser"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        cekSessionModel = CekSessionModel.fromJson(result);
        statusSession.value = cekSessionModel!.status;
        print(statusSession);
        if (cekSessionModel!.status != "sukses") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('biometric');
          prefs.remove('id_user');
          prefs.remove('email');
          prefs.remove('token');
          prefs.remove('name');
          prefs.remove('jabatan');
          prefs.remove('kode_cabang');
          prefs.remove('bagian');
          prefs.remove('role');
          prefs.remove('nip');
          prefs.remove('password');
          prefs.remove('sub_divisi');
          prefs.clear();
          prefs.reload();
        }
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

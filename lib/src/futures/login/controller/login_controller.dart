import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:los_mobile/src/futures/login/view/login.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';
import 'package:los_mobile/src/widgets/my_snackbar.dart';
import 'package:los_mobile/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailNipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;

  Future<void> login() async {
    var headers = {'Content-Type': 'application/json'};

    try {
      Map body = {
        "email": emailNipController.text,
        "password": passwordController.text,
      };

      http.Response response = await http.post(
        Uri.parse("$base_url/login"),
        body: jsonEncode(body),
        headers: headers,
      );

      if (emailNipController.text == "" || passwordController.text == "") {
        snackbarError("Harap di isi semua");
      } else {
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          if (json["status"] == "berhasil") {
            var token = json['access_token'];
            var email = json['email'];
            var role = json['role'];
            var data = json['data'];
            var name = data['nama'];
            // deklarasi key jabatan
            Map<String, dynamic> jabatan = data['jabatan'];
            var nama_jabatan = jabatan['nama_jabatan'];

            // Cek type entitas apkah 1 atau 2
            if (data['entitas']['type'] != 1) {
              prefs = await SharedPreferences.getInstance();
              var cab = data['entitas']['cab'];
              var kodeCabang = cab['kd_cabang'];
              await prefs?.setString('kode_cabang', kodeCabang);
            }

            // Cek bagian apakah null jika tidak maka simpan bagian
            if (data['bagian'] != null) {
              prefs = await SharedPreferences.getInstance();
              var bagian = data['bagian']['nama_bagian'];
              await prefs?.setString('bagian', bagian);
            }

            // Simpan ke Storage
            prefs = await SharedPreferences.getInstance();
            await prefs?.setString('email', email);
            await prefs?.setString('token', token);
            await prefs?.setString('name', name);
            await prefs?.setString('jabatan', nama_jabatan);
            await prefs?.setString('role', role);
            emailNipController.clear();
            passwordController.clear();
            Get.offAll(const MyBottomNavigationBar());
          } else {
            print(response.statusCode);
          }
        } else {
          final json = jsonDecode(response.body);
          snackbarError(json['message']);
        }
      }
    } catch (e) {
      snackbarError(e.toString());
    }
  }

  Future<void> logout() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs?.getString("token");
    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    try {
      var url = Uri.parse("$base_url/logout");
      http.Response response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        prefs?.remove('email');
        prefs?.remove('token');
        prefs?.remove('name');
        prefs?.remove('jabatan');
        prefs?.remove('kode_cabang');
        prefs?.remove('bagian');
        prefs?.remove('role');
        prefs?.clear();
        Get.offAll(const Login());
      } else {
        snackbarError(response.statusCode.toString());
      }
    } catch (e) {
      snackbarError(e.toString());
    }
  }
}

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
  var isLoading = false.obs;

  Future<void> login() async {
    var headers = {'Content-Type': 'application/json'};

    try {
      isLoading(true);

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
            var data = json['data'];
            Map<String, dynamic> entitas = data['entitas'];

            int idUser = json['id'];
            String email = json['email'];
            String role = json['role'];
            String token = json['access_token'];
            String name = data['nama'];
            String namaJabatan = data['nama_jabatan'];
            String nip = data['nip'];

            if (entitas['type'] != 1) {
              prefs = await SharedPreferences.getInstance();
              Map<String, dynamic> cab = entitas['cab'];
              String kodeCabang = cab['kd_cabang'];
              await prefs?.setString('kode_cabang', kodeCabang);
            }

            if (data['bagian'] != null) {
              prefs = await SharedPreferences.getInstance();
              Map<String, dynamic> bagian = data['bagian'];
              String namaBagian = bagian['nama_bagian'];
              await prefs?.setString('bagian', namaBagian);
            }

            // Simpan ke Storage
            prefs = await SharedPreferences.getInstance();
            await prefs?.setInt('id_user', idUser);
            await prefs?.setString('email', email);
            await prefs?.setString('token', token);
            await prefs?.setString('name', name);
            await prefs?.setString('jabatan', namaJabatan);
            await prefs?.setString('role', role);
            await prefs?.setString('nip', nip);
            await prefs?.setString('password', passwordController.text);
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
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs?.getString("token");
    print(token);
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
        prefs?.remove('id_user');
        prefs?.remove('email');
        prefs?.remove('token');
        prefs?.remove('name');
        prefs?.remove('jabatan');
        prefs?.remove('kode_cabang');
        prefs?.remove('bagian');
        prefs?.remove('role');
        prefs?.remove('biometric');
        prefs?.remove('nip');
        prefs?.remove('password');
        prefs?.clear();
        Get.offAll(Login(biometric: false));
      } else {
        snackbarError(response.statusCode.toString());
      }
    } catch (e) {
      snackbarError(e.toString());
    }
  }
}

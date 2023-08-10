import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/home_page.dart';
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
      var url = Uri.parse("$base_url/login");
      Map body = {
        "email": emailNipController.text,
        "password": passwordController.text,
      };

      http.Response response = await http.post(
        url,
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
            prefs = await SharedPreferences.getInstance();
            await prefs?.setString('email', email);
            await prefs?.setString('token', token);
            emailNipController.clear();
            passwordController.clear();
            Get.offAll(const MyBottomNavigationBar());
            print(response.body);
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
        Get.offAll(const Login());
      } else {
        snackbarError(response.statusCode.toString());
      }
    } catch (e) {
      snackbarError(e.toString());
    }
  }
}

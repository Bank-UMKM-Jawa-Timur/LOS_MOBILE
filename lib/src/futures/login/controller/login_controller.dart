import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/login/models/login_admin_model.dart';
import 'package:los_mobile/src/futures/login/models/login_entitas_type_two_model.dart';
import 'package:los_mobile/src/futures/login/models/login_type_null.dart';

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
  LoginAdminModel? loginAdminModel;
  LoginTypeNullModel? loginTypeNullModel;
  LoginEntitasTypeTwoModel? loginEntitasTypeTwoModel;
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
          if (json['data'] == "undifined") {
            snackbarError("Terjadi kesalahan pada server atau api undifined");
          } else {
            if (json["status"] == "berhasil") {
              String role = json['role'];

              // Response login setiap user berbeda maka dibuat 3 model
              // Cek Jika Direksi maka pake model direksi
              if (role == 'Direksi') {
                prefs = await SharedPreferences.getInstance();
                loginTypeNullModel = LoginTypeNullModel.fromJson(json);
                await prefs?.setInt('id_user', loginTypeNullModel!.id);
                await prefs?.setString('email', loginTypeNullModel!.email);
                await prefs?.setString(
                    'token', loginTypeNullModel!.accessToken);
                await prefs?.setString('name', loginTypeNullModel!.data.nama);
                // Dikarenakan Direksi jabatan null maka untuk menampilkan ke Home jabatan menggunakan role
                await prefs?.setString('jabatan', loginTypeNullModel!.role);
                await prefs?.setString('role', loginTypeNullModel!.role);
              } else {
                var data = json['data'];
                Map<String, dynamic> entitas = data['entitas'];

                //Jika Entitas type 1 maka menggunakan model LoginAdminModel
                //Jika Entitas type 2 maka menggunakan model LoginEntitasTypeTwoModel
                if (entitas['type'] == 1) {
                  prefs = await SharedPreferences.getInstance();
                  loginAdminModel = LoginAdminModel.fromJson(json);
                  await prefs?.setInt('id_user', loginAdminModel!.id);
                  await prefs?.setString('email', loginAdminModel!.email);
                  await prefs?.setString('token', loginAdminModel!.accessToken);
                  await prefs?.setString('name', loginAdminModel!.data.nama);
                  await prefs?.setString(
                      'jabatan', loginAdminModel!.data.namaJabatan);
                  await prefs?.setString('role', loginAdminModel!.role);
                  await prefs?.setString('nip', loginAdminModel!.data.nip);
                  // Pengecekan jika type entitas 1 dan role PSD maka menggunakan sub_divisi
                  if (loginAdminModel!.data.jabatan.kdJabatan == "PSD") {
                    var subDivisi =
                        json['data']['entitas']['subDiv']['nama_subdivisi'];
                    await prefs?.setString('bagian', subDivisi);
                    // Cek jika jabatan PIMDIV maka bagian menggunakan divisi
                  } else if (loginAdminModel!.data.jabatan.kdJabatan ==
                      "PIMDIV") {
                    var divisi = json['data']['entitas']['div']['nama_divisi'];
                    await prefs?.setString('bagian', divisi);
                  } else {
                    await prefs?.setString(
                        'bagian', loginAdminModel!.data.bagian['nama_bagian']);
                  }
                } else {
                  prefs = await SharedPreferences.getInstance();
                  loginEntitasTypeTwoModel =
                      LoginEntitasTypeTwoModel.fromJson(json);
                  await prefs?.setInt('id_user', loginEntitasTypeTwoModel!.id);
                  await prefs?.setString(
                      'email', loginEntitasTypeTwoModel!.email);
                  await prefs?.setString(
                      'token', loginEntitasTypeTwoModel!.accessToken);
                  await prefs?.setString(
                      'name', loginEntitasTypeTwoModel!.data.nama);
                  await prefs?.setString(
                      'jabatan', loginEntitasTypeTwoModel!.data.namaJabatan);
                  await prefs?.setString(
                      'role', loginEntitasTypeTwoModel!.role);
                  await prefs?.setString(
                      'nip', loginEntitasTypeTwoModel!.data.nip);
                  await prefs?.setString('kode_cabang',
                      loginEntitasTypeTwoModel!.data.entitas.cab.kdCabang);
                  // Melakukan Pengecekan jika key bagian tidak null
                  if (json['data']['bagian'] != null) {
                    await prefs?.setString('bagian',
                        loginEntitasTypeTwoModel!.data.bagian['nama_bagian']);
                  }
                }
              }

              await prefs?.setString('password', passwordController.text);
              emailNipController.clear();
              passwordController.clear();
              Get.offAll(const MyBottomNavigationBar());
            } else {
              print(response.statusCode);
            }
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
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse("$base_url/logout");
      http.Response response = await http.post(
        url,
        headers: headers,
      );
      print(response.statusCode);
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
        prefs?.remove('sub_divisi');
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

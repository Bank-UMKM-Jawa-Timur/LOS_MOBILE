import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/los_connection/los_connection_page.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult? result;
  var checkConnection = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.to(const LosConnectionPage());
      // );
    } else {
      Get.back();
    }
  }
}

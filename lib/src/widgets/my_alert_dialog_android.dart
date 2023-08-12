import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/login/controller/login_controller.dart';
import 'package:los_mobile/utils/colors.dart';

LoginController loginController = Get.put(LoginController());
alertDialogAndroidLogout(BuildContext context, String title, String message) {
  return AlertDialog(
    title: Text(
      title,
      style: const TextStyle(
        color: mPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Text(message),
    actions: <Widget>[
      TextButton(
        child: const Text(
          "No",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text(
          "Oke",
          style: TextStyle(
            color: mPrimaryColor,
          ),
        ),
        onPressed: () {
          loginController.logout();
        },
      ),
    ],
    elevation: 24.0,
  );
}

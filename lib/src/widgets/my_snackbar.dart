import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackbarError(String message) {
  return Get.rawSnackbar(
    title: "Error",
    message: message,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.white,
    ),
    backgroundColor: Colors.red,
  );
}

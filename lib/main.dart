import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/login/view/login.dart';
import 'package:los_mobile/src/futures/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  void splash() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(const Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: CekPage(),
    );
  }
}

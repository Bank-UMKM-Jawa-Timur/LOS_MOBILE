import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:los_mobile/src/futures/login/view/login.dart';
import 'package:los_mobile/src/futures/splash_screen/splash_screen.dart';

Future<void> main() async {
  // Solve certificate error when api request to server
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const GetMaterialApp(
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

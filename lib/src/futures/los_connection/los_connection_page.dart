import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/utils/colors.dart';

class LosConnectionPage extends StatelessWidget {
  const LosConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width / 1,
              height: Get.height / 3.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/no_connection.png"),
              )),
            ),
            spaceHeightMedium,
            const Text(
              "Koneksi Internet Teputus!",
              style: textBoldDarkVeryLarge,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Uppss, koneksi anda terputus silahkan hubungkan ulang koneksi anda",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: mGreyFlatColor),
              ),
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: mPrimaryColor),
                onPressed: () async {
                  ConnectivityResult result =
                      await Connectivity().checkConnectivity();
                  if (result == ConnectivityResult.none) {
                    debugPrint("NO INTERNET");
                  } else {
                    Get.back();
                  }
                },
                child: const Text("Coba lagi"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

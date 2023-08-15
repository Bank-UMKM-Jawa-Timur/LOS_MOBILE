import 'package:flutter/material.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/utils/colors.dart';

class MyAlertDialog {
  alertdialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 265,
        child: Center(
          child: SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/ingfo.png",
                  ),
                  const SizedBox(height: 20),
                  const Text("Coming Soon!",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.4,
                      )),
                  spaceHeightMedium,
                  const SizedBox(
                    width: 200,
                    child: Text(
                        "Mohon maaf untuk saat ini fitur masih dikembangkan!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  spaceHeightLarge,
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(mPrimaryColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Oke")),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

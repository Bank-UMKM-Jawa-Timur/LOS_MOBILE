import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/utils/colors.dart';

class MyAlertDialog {
  alertdialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            width: 550,
            height: 270,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 50),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/ingfo.png",
                  ),
                  SizedBox(height: 20),
                  Text("Coming Soon!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.4,
                      )),
                  SizedBox(height: 20),
                  Container(
                    width: 200,
                    child: Text(
                        "Mohon maaf untuk saat ini fitur masih dikembangkan!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(mPrimaryColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Oke")),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}

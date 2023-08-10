import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool beoAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // bagian avatar
                Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(top: 70),
                    child: CircleAvatar(
                      child: new Text(
                        'A',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      backgroundColor: avatarColor,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("Arsyad Arthan Nurrohim",
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("admin@mail.com",
                        style: new TextStyle(
                            color: textEmail,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal))),

                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 40),
                  child: Column(children: [
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                buttonRadius), // <-- Radius
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(16),
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                        ),
                        icon: Icon(Icons.lock_reset, size: 28.0),
                        onPressed: () {},
                        label: Text(
                          'Ganti Password',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: spacingColumn),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(buttonRadius))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Beomatric Authentication',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Switch(
                            activeColor: Colors.red[900],
                            value: beoAuth,
                            onChanged: (bool value) {
                              setState(() {
                                beoAuth = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spacingColumn),
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: primary,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                buttonRadius), // <-- Radius
                          ),
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                        ),
                        icon: Icon(Icons.logout, size: 20),
                        onPressed: () {},
                        label: Text(
                          'Logout',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// digunakan untuk mengconvert hexa color ke bawaan flutter color
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color primary = HexColor("#EE2649");
Color avatarColor = HexColor("#4B64E2");
Color textEmail = HexColor("#767E89");

double spacingColumn = 15;
double buttonRadius = 8;
double buttonWidth = 350;
double buttonHeight = 40;

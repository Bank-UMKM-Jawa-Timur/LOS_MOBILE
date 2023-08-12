import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:los_mobile/src/widgets/dialog/my_alert_dialog_android.dart';
import 'package:los_mobile/src/widgets/dialog/my_alert_dialog_ios.dart';
import 'package:los_mobile/src/widgets/my_circle_avatar.dart';
import 'package:los_mobile/src/widgets/my_shorten_last_name.dart';
import 'package:los_mobile/src/widgets/my_target_platform.dart';
import 'package:los_mobile/src/widgets/my_text_widget.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/src/futures/login/controller/login_controller.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool beoAuth = false;
  LoginController loginController = Get.put(LoginController());
  PreferensUser preferensUser = Get.put(PreferensUser());

  Future<void> alert() async {
    print("object");
  }

  String name = "";
  String jabatan = "";
  String bagian = "";
  String role = "";
  String email = "";

  bool typeFilter = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  totalPengajuan() {}

  void getUser() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = "${spref.getString("name")}";
      jabatan = "${spref.getString("jabatan")}";
      bagian = "${spref.getString("bagian")}";
      role = "${spref.getString("role")}";
      email = "${spref.getString("email")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBgColor,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Profile", style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: mBgColor,
        elevation: 0,
        centerTitle: false,
      ),
      body: Obx(
        () => preferensUser.isLoading.value
            ? const CircularProgressIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // bagian avatar
                      circleAvatarWidget(name, 50),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          shortenLastName(name),
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          email,
                          style: TextStyle(
                              color: textEmail,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 40),
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
                                padding: const EdgeInsets.all(16),
                                splashFactory: NoSplash.splashFactory,
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.lock_reset, size: 28.0),
                              onPressed: () {},
                              label: const Text(
                                'Ganti Password',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: spacingColumn),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(buttonRadius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Icon(
                                        Icons.fingerprint,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Text(
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
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      buttonRadius), // <-- Radius
                                ),
                                splashFactory: NoSplash.splashFactory,
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.logout, size: 20),
                              onPressed: () {
                                if (defaultTargetPlatform == deviceAndroid) {
                                  alertDialogAndroidLogout(
                                    context,
                                    titleDialogWarning,
                                    messageeDialoglogout,
                                  );
                                } else if (defaultTargetPlatform == deviceIos) {
                                  AlertDialogIosLogout(
                                    context,
                                    titleDialogWarning,
                                    messageeDialoglogout,
                                  );
                                }
                              },
                              label: const Text(
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
              ),
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

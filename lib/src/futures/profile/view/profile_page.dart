import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
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
  bool isAuthBiometric = false;
  late final LocalAuthentication auth;
  bool _supportState = false;

  LoginController loginController = Get.put(LoginController());
  PreferensUser preferensUser = Get.put(PreferensUser());
  CircleAvatarWidget circleAvatarWidget = Get.put(CircleAvatarWidget());

  String name = "";
  String jabatan = "";
  String bagian = "";
  String role = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
    getUser();
  }

  void getUser() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    name = "${spref.getString("name")}";
    jabatan = "${spref.getString("jabatan")}";
    bagian = "${spref.getString("bagian")}";
    role = "${spref.getString("role")}";
    email = "${spref.getString("email")}";
    isAuthBiometric = spref.getBool("biometric") == null
        ? false
        : spref.getBool("biometric")!;
    print(isAuthBiometric);
    setState(() {});
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
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // bagian avatar
                      circleAvatarWidget.circleAvatarWidget(name, 50),
                      spaceHeightMedium,
                      Text(
                        shortenLastName(name),
                        style: textBoldDarkVeryLarge,
                      ),
                      spaceHeightSmall,
                      Text(
                        email,
                        style: const TextStyle(
                          color: mGreyFlatColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Column(children: [
                          _bottomChangePassword(),
                          _supportState
                              ? Column(
                                  children: [
                                    spaceHeightMedium,
                                    _bottomAuth(),
                                  ],
                                )
                              : Container(),
                          spaceHeightMedium,
                          _bottomLogout(context),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  SizedBox _bottomChangePassword() {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: mPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
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
    );
  }

  Widget _bottomAuth() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: Get.width,
      decoration: const BoxDecoration(
        color: mPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
                  'Biomatric Authentication',
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
            value: isAuthBiometric,
            onChanged: (bool value) async {
              setState(() {
                isAuthBiometric = value;
              });
              if (isAuthBiometric) {
                showCupertinoModalPopup<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("INFO"),
                    content: const Text("Apakah Ingin Menggunakan Biometric ?"),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.remove("biometric");
                          prefs.setBool("biometric", false);
                          isAuthBiometric = false;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: const Text('No'),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        isDestructiveAction: true,
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setBool("biometric", true);
                          isAuthBiometric = true;
                          setState(() {});
                          _authenticate();
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              } else {
                showCupertinoModalPopup<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("INFO"),
                    content:
                        const Text("Apakah Ingin Menonaktifkan Biometric ?"),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () async {
                          isAuthBiometric = true;
                          setState(() {});
                          Get.back();
                        },
                        child: const Text('No'),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        isDestructiveAction: true,
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.remove("biometric");
                          prefs.setBool("biometric", false);
                          isAuthBiometric = false;
                          setState(() {});
                          Get.back();
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox _bottomLogout(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: mPrimaryColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
        ),
        icon: const Icon(Icons.logout, size: 20),
        onPressed: () {
          if (defaultTargetPlatform == deviceAndroid) {
            AlertDialogIosLogout(
              context,
              titleDialogWarning,
              messageeDialoglogout,
            );
            // alertDialogAndroidLogout(
            //   context,
            //   titleDialogWarning,
            //   messageeDialoglogout,
            // );
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
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "Use your Finger or Face",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Get.back();
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();
  //   print("List of available Biometrics : $availableBiometrics");

  //   if (!mounted) {
  //     return;
  //   }
  // }
}

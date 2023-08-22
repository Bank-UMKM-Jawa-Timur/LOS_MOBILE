import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:los_mobile/src/futures/login/controller/cek_session_login.dart';
import 'package:los_mobile/src/futures/login/controller/login_controller.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';
import 'package:los_mobile/src/widgets/my_logo.dart';
import 'package:los_mobile/src/widgets/my_snackbar.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());
  CekSessionLogin cekSessionLogin = Get.put(CekSessionLogin());
  PreferensUser preferensUser = Get.put(PreferensUser());
  bool isAuthBiometric = false;
  late final LocalAuthentication auth;
  bool supportState = false;
  SharedPreferences? spref;

  @override
  void initState() {
    cekSession();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          supportState = isSupported;
        }));
    super.initState();
  }

  cekSession() async {
    spref = await SharedPreferences.getInstance();
    isAuthBiometric = spref!.getBool('biometric') == null
        ? false
        : spref!.getBool('biometric')!;
    setState(() {});
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "Subcribe or you will",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Get.offAll(const MyBottomNavigationBar());
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => preferensUser.isLoading.value
            ? const CircularProgressIndicator()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logoLogin,
                      spaceHeightVeryLarge,
                      Column(
                        children: [
                          _textInputEmail(),
                          spaceHeightSecondMedium,
                          _textInputPassword(),
                        ],
                      ),
                      spaceHeightSecondLarge,
                      _buttomLogin()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  SizedBox _textInputEmail() {
    return SizedBox(
      height: 50,
      child: TextField(
        style: const TextStyle(color: mSecondaryDarkColor),
        cursorColor: const Color(0xFF737373),
        decoration: const InputDecoration(
          hintText: 'Masukkan Email atau NIP',
          hintStyle: TextStyle(color: mSecondaryDarkColor, fontSize: 13),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: mSecondaryDarkColor,
          ),
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
        ),
        autocorrect: false,
        maxLines: 1,
        controller: loginController.emailNipController,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  SizedBox _textInputPassword() {
    return SizedBox(
      height: 50,
      child: TextField(
        style: const TextStyle(color: mSecondaryDarkColor),
        cursorColor: const Color(0xFF737373),
        decoration: const InputDecoration(
          hintText: 'Masukkan Password',
          hintStyle: TextStyle(color: mSecondaryDarkColor, fontSize: 13),
          prefixIcon: Icon(
            CommunityMaterialIcons.lock_outline,
            color: mSecondaryDarkColor,
          ),
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
        ),
        autocorrect: false,
        maxLines: 1,
        obscureText: true,
        enableSuggestions: false,
        controller: loginController.passwordController,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buttomLogin() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: mPrimaryColor,
              ),
              onPressed: loginController.isLoading.value
                  ? null
                  : () async {
                      if (cekSessionLogin.cekSessionModel?.status == "sukses") {
                        print("Session ligin dijalankan");
                        var sprefs = await SharedPreferences.getInstance();
                        if ((loginController.emailNipController.text ==
                                    sprefs.getString("email") ||
                                loginController.emailNipController.text ==
                                    sprefs.getString("nip")) &&
                            loginController.passwordController.text ==
                                sprefs.getString("password")) {
                          if (cekSessionLogin.cekSessionModel?.status ==
                              "sukses") {
                            Get.offAll(const MyBottomNavigationBar());
                          } else {
                            loginController.login();
                          }
                        } else {
                          snackbarError("Email atau NIP dan Password Salah");
                        }
                      } else {
                        loginController.login();
                        print("Controller ligin dijalankan");
                      }
                    },
              icon: const Icon(CommunityMaterialIcons.login),
              label: Text(
                loginController.isLoading.value ? "Loading..." : "Login",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        if (cekSessionLogin.cekSessionModel?.status == "sukses")
          if (isAuthBiometric == true) spaceWidthVerySmall else const SizedBox()
        else
          const SizedBox(),
        if (cekSessionLogin.statusSession.value == "sukses")
          if (isAuthBiometric == true)
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: _authenticate,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: mPrimaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: GetPlatform.isIOS
                      ? Container(
                          margin: const EdgeInsets.all(3),
                          child: Image.asset("assets/icon/face_id.png"))
                      : const Icon(
                          CommunityMaterialIcons.fingerprint,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
              ),
            )
          else
            Container()
        else
          Container(),
      ],
    );
  }
}

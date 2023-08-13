import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/view/home_page.dart';
import 'package:los_mobile/src/futures/login/controller/login_controller.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';
import 'package:los_mobile/src/widgets/my_logo.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      Get.offAll(const MyBottomNavigationBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoLogin,
                spaceHeightVeryLarge,
                _textInputEmail(),
                spaceHeightSecondMedium,
                _textInputPassword(),
                spaceHeightSecondLarge,
                _buttomLogin(),
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

  SizedBox _buttomLogin() {
    return SizedBox(
      width: Get.width,
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: mPrimaryColor,
        ),
        onPressed: () {
          loginController.login();
        },
        icon: const Icon(CommunityMaterialIcons.login),
        label: Text(
          loginController.isLoading.value ? "Loading..." : "Login",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

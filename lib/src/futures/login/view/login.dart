import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';
import 'package:los_mobile/src/widgets/my_logo.dart';
import 'package:los_mobile/utils/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailNip = TextEditingController(text: "");
  var password = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoLogin,
              spaceHeightVeryLarge,
              SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: mSecondaryDarkColor),
                  cursorColor: const Color(0xFF737373),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Email atau NIP',
                    hintStyle:
                        TextStyle(color: mSecondaryDarkColor, fontSize: 13),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: mSecondaryDarkColor,
                    ),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  controller: emailNip,
                  textInputAction: TextInputAction.next,
                ),
              ),
              spaceHeightSecondMedium,
              SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: mSecondaryDarkColor),
                  cursorColor: const Color(0xFF737373),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Password',
                    hintStyle:
                        TextStyle(color: mSecondaryDarkColor, fontSize: 13),
                    prefixIcon: Icon(
                      CommunityMaterialIcons.lock_outline,
                      color: mSecondaryDarkColor,
                    ),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  controller: password,
                  textInputAction: TextInputAction.next,
                ),
              ),
              spaceHeightSecondLarge,
              SizedBox(
                width: Get.width,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mPrimaryColor,
                  ),
                  onPressed: () {
                    Get.offAll(const MyBottomNavigationBar());
                  },
                  icon: const Icon(CommunityMaterialIcons.login),
                  label: const Text(
                    "Login",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

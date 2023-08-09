import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/view/home/home_page.dart';
import 'package:los_mobile/widgets/NavigationBar/bottom_navigation.dart';
import 'package:los_mobile/widgets/Space/widget_space.dart';
import 'package:los_mobile/widgets/colors/theme.dart';
import 'package:los_mobile/widgets/form/widget_form.dart';
import 'package:los_mobile/widgets/logo/widget_logo.dart';

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
              WidgetLogo().logoLogin,
              WidgetSpace().spaceHeight(55),
              SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: WidgetTheme.secondaryColor),
                  cursorColor: const Color(0xFF737373),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Email atau NIP',
                    hintStyle: TextStyle(
                        color: WidgetTheme.secondaryColor, fontSize: 13),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: WidgetTheme.secondaryColor,
                    ),
                    focusedBorder: WidgetForm.focusedBorderWidget,
                    enabledBorder: WidgetForm.enabledBorderWidget,
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  controller: emailNip,
                  textInputAction: TextInputAction.next,
                ),
              ),
              WidgetSpace().spaceHeight(14),
              SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: WidgetTheme.secondaryColor),
                  cursorColor: const Color(0xFF737373),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Password',
                    hintStyle: TextStyle(
                        color: WidgetTheme.secondaryColor, fontSize: 13),
                    prefixIcon: Icon(
                      CommunityMaterialIcons.lock_outline,
                      color: WidgetTheme.secondaryColor,
                    ),
                    focusedBorder: WidgetForm.focusedBorderWidget,
                    enabledBorder: WidgetForm.enabledBorderWidget,
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  controller: password,
                  textInputAction: TextInputAction.next,
                ),
              ),
              WidgetSpace().spaceHeight(24),
              SizedBox(
                width: Get.width,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WidgetTheme.primaryColor,
                  ),
                  onPressed: () {
                    Get.offAll(const BottomNavigationBarExample());
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

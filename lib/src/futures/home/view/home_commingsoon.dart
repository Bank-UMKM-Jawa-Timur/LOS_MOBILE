import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCommingsoon extends StatefulWidget {
  const HomeCommingsoon({super.key});

  @override
  State<HomeCommingsoon> createState() => _HomeCommingsoonState();
}

class _HomeCommingsoonState extends State<HomeCommingsoon> {
  PreferensUser preferensUser = Get.put(PreferensUser());
  String? role;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    await SharedPreferences.getInstance();
    setState(() {
      role = preferensUser.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outlined,
                size: 65,
                color: mPrimaryColor,
              ),
              spaceHeightLarge,
              const Text(
                "Comming Soon",
                style: textBoldDarkVeryLarge,
              ),
              spaceHeightSmall,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Bagian ',
                  style: textColorBoldDarkSmall(13, mGreyFlatColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$role',
                      style: textColorBoldDarkSmall(14, mPrimaryColor),
                    ),
                    const TextSpan(
                      text: ' masih proses pengembangan',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

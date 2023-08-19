import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';

class CircleAvatarWidget extends GetxController {
  circleAvatarWidget(String name, double radius, double sizeText) {
    return CircleAvatar(
        backgroundColor: const Color(0xFF4B64E2),
        radius: radius,
        child: Text(
          name.isNotEmpty ? name[0] : "",
          style: textColorBoldDarkSmall(sizeText, Colors.white),
        ));
    //   backgroundImage: NetworkImage(
    //       "https://ui-avatars.com/api/?name=$name&background=4B64E2&color=fff&bold=true&length=1"),
    // );
  }
}

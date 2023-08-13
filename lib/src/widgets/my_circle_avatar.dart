import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarWidget extends GetxController {
  circleAvatarWidget(String name, double radius) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF4B64E2),
      radius: radius,
      backgroundImage: NetworkImage(
          "https://ui-avatars.com/api/?name=$name&background=4B64E2&color=fff&bold=true&length=1"),
    );
  }
}

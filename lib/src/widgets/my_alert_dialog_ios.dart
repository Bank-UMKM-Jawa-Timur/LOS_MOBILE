import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/login/controller/login_controller.dart';

LoginController loginController = Get.put(LoginController());
AlertDialogIosLogout(
  BuildContext context,
  String title,
  String message,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          isDestructiveAction: true,
          onPressed: () {
            loginController.logout();
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

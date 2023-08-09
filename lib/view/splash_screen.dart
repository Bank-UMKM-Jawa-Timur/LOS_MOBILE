import 'package:flutter/material.dart';
import 'package:los_mobile/widgets/logo/widget_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WidgetLogo().logoSplash,
      ),
    );
  }
}

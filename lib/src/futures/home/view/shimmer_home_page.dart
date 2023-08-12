import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/my_shimmer.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomePage extends StatefulWidget {
  const ShimmerHomePage({super.key});

  @override
  State<ShimmerHomePage> createState() => _ShimmerHomePageState();
}

class _ShimmerHomePageState extends State<ShimmerHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: mBgColor,
      appBar: _buildAppBar(heightStatusBar),
      body: MyShimmer().buildBody(),
    );
  }

  AppBar _buildAppBar(double heightStatusBar) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      toolbarHeight: heightStatusBar + 20,
      titleSpacing: -30,
      leading: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              child: CircleAvatar(),
              baseColor: mGreyVeryLightColor,
              highlightColor: Colors.white,
            ),
          ],
        ),
      ),
      centerTitle: false,
      title: Shimmer.fromColors(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 186,
              height: 17,
              color: Colors.grey,
            ),
            SizedBox(height: 3),
            Container(
              width: 85,
              height: 8,
              color: Colors.grey,
            )
          ],
        ),
        baseColor: mGreyVeryLightColor,
        highlightColor: Colors.white,
      ),
      actions: [
        Shimmer.fromColors(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              width: 30,
              // height: 25,
              color: Colors.white,
            ),
          ),
          baseColor: mGreyVeryLightColor,
          highlightColor: Colors.white,
        )
      ],
      automaticallyImplyLeading: true,
      leadingWidth: Get.width * 0.28,
      elevation: 0,
    );
  }
}

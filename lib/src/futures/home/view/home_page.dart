import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future refresh() async {
    setState(() {
      print(1 + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: mPrimaryColor,
        toolbarHeight: heightStatusBar + 20,
        titleSpacing: -30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 41,
                height: 41,
                decoration: const BoxDecoration(
                  color: Color(0xFF4B64E2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "A",
                    style: textBoldLightSecondLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Arsyad Arthan Nurrohim",
              style: textBoldLightLarge,
            ),
            SizedBox(height: 3),
            Text(
              "Staf Service & Operation",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Color(0xFFEBEBEB),
              ),
            )
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(
              Icons.notifications_none,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
        automaticallyImplyLeading: true,
        leadingWidth: Get.width * 0.28,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: mPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: Get.height * 0.11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              shadowMedium,
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Periode : ",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: mPrimaryColor,
                                          ),
                                        ),
                                        Text(
                                          "01-Juni-2023 s/d 30-juni-2023",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Cabang : ",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: mPrimaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Keseluruhan",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 1,
                                        height: 25,
                                        color: const Color(0xFF9B9B9B),
                                      ),
                                      spaceWidthVerySmall,
                                      InkWell(
                                        onTap: () {
                                          print("object");
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        spaceHeightLarge,
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              shadowMedium,
                            ],
                          ),
                        ),
                        spaceHeightLarge,
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              shadowMedium,
                            ],
                          ),
                        ),
                        spaceHeightLarge,
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              shadowMedium,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

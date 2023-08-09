import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/widgets/Space/widget_space.dart';
import 'package:los_mobile/widgets/colors/theme.dart';
import 'package:los_mobile/widgets/shadow/widget_shadow.dart';
import 'package:los_mobile/widgets/text/widget_text.dart';

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
        backgroundColor: WidgetTheme.primaryColor,
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
                child: Center(
                  child: Text(
                    "A",
                    style: WidgetText().textStyleBold(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Arsyad Arthan Nurrohim",
              style: WidgetText().textStyleBold(15),
            ),
            WidgetSpace().spaceHeight(2),
            const Text(
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
      body: RefreshIndicator(
        color: Colors.red,
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: WidgetTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    // child: Column(
                    //   children: [
                    //     WidgetSpace().spaceHeight(heightStatusBar),
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Container(
                    //               width: 41,
                    //               height: 41,
                    //               decoration: const BoxDecoration(
                    //                 color: Color(0xFF4B64E2),
                    //                 borderRadius: BorderRadius.all(
                    //                   Radius.circular(30),
                    //                 ),
                    //               ),
                    //               child: Center(
                    //                   child: Text(
                    //                 "A",
                    //                 style: WidgetText().textStyleBold(20),
                    //               )),
                    //             ),
                    //             WidgetSpace().spaceWidth(12),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "Arsyad Arthan Nurrohim",
                    //                   style: WidgetText().textStyleBold(15),
                    //                 ),
                    //                 const Text(
                    //                   "Staf Service & Operation",
                    //                   style: TextStyle(
                    //                     fontSize: 9,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: Color(0xFFEBEBEB),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         const Icon(
                    //           Icons.notifications_none,
                    //           size: 30,
                    //           color: Colors.white,
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Get.height * 0.11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              WidgetShadow().shadowCard(),
                            ],
                          ),
                        ),
                        WidgetSpace().spaceHeight(13),
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              WidgetShadow().shadowCard(),
                            ],
                          ),
                        ),
                        WidgetSpace().spaceHeight(13),
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              WidgetShadow().shadowCard(),
                            ],
                          ),
                        ),
                        WidgetSpace().spaceHeight(13),
                        Container(
                          height: 245,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              WidgetShadow().shadowCard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

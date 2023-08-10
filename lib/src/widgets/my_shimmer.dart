import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer {
  buildBody() {
    return Container(
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                // margin: EdgeInsets.only(top: 0),
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSize(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            shadowMedium,
                          ],
                        ),
                        child: _cardFilter(),
                      ),
                    ),
                    spaceHeightMedium,
                    _dataPengajuan(),
                    spaceHeightMedium,
                    _posisiPengajuan(),
                    // spaceHeightMedium,
                    // _ratingCabang(),
                    // spaceHeightMedium,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _cardFilter() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 185,
                      height: 17,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: 130,
                      height: 17,
                      color: Colors.grey,
                    ),
                  ],
                ),
                baseColor: mGreyVeryLightColor,
                highlightColor: Colors.white,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 1,
                      height: 25,
                      color: const Color(0xFF9B9B9B),
                    ),
                    spaceWidthSmall,
                    Shimmer.fromColors(
                      child: Container(
                        width: 19,
                        height: 19,
                        color: Colors.grey,
                      ),
                      baseColor: mGreyVeryLightColor,
                      highlightColor: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _dataPengajuan() {
    return Container(
      width: Get.width,
      height: 245,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          shadowMedium,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Shimmer.fromColors(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 186,
                    height: 17,
                    color: Colors.grey,
                  ),
                ],
              ),
              spaceHeightLarge,
              Container(
                width: 217,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              spaceHeightMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70,
                    height: 15,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 70,
                    height: 15,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 70,
                    height: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          baseColor: mGreyVeryLightColor,
          highlightColor: Colors.white,
        ),
      ),
    );
  }

  Container _posisiPengajuan() {
    return Container(
      width: Get.width,
      height: 245,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          shadowMedium,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Shimmer.fromColors(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 145,
                    height: 17,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 17,
                        color: Colors.grey,
                      ),
                      spaceWidthSmall,
                      Container(
                        width: 55,
                        height: 17,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              spaceHeightMedium,
              spaceHeightSmall,
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.amber,
                            height: 30,
                          ),
                        ),
                        spaceWidthVerySmall,
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.amber,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          baseColor: mGreyVeryLightColor,
          highlightColor: Colors.white,
        ),
      ),
    );
  }
}

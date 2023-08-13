import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/view/shimmer_home_page.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/dialog/my_alert_dialog.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_circle_avatar.dart';
import 'package:los_mobile/src/widgets/date/my_date_picker_android.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
import 'package:los_mobile/src/widgets/my_pie_chart.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/src/widgets/my_shorten_last_name.dart';
import 'package:los_mobile/src/widgets/my_target_platform.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/utils/constant.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:los_mobile/utils/role_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  DataPengajuanController dataPengajuanController =
      Get.put(DataPengajuanController());
  DataCabangController dataCabangController = Get.put(DataCabangController());
  PosisiPengajuanController posisiPengajuanController =
      Get.put(PosisiPengajuanController());
  PreferensUser preferensUser = Get.put(PreferensUser());

  String name = "";
  String jabatan = "";
  String bagian = "";
  String role = "";
  String kodeCabang = "";

  String? valueCabang;
  String? filterCabang;
  String? filterRating;
  String? filterCodeCabang;

  bool typeFilter = false;
  @override
  void initState() {
    super.initState();
    getUser();
    filterCabang = "Semua cabang";
    filterRating = "Semua cabang";
    print("filterCodeCabang $filterCabang");
    print("kodeCabang $kodeCabang");
  }

  totalPengajuan() {}

  void getUser() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = "${spref.getString("name")}";
      jabatan = "${spref.getString("jabatan")}";
      bagian = "${spref.getString("bagian")}";
      role = "${spref.getString("role")}";
      kodeCabang = "${spref.getString("kode_cabang")}";
    });
  }

  Future refresh() async {
    setState(() {
      print(1 + 1);
    });
  }

  final colorListData = <Color>[
    mGreenFlatColor,
    mPrimaryColor,
    mYellowColor,
  ];

  final colorListPosisi = <Color>[
    mBlueFlatColor,
    mAmberFlatColor,
    mPurpleLightColor,
    mPinkLightColor,
    mBlueLightColor,
  ];

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).viewPadding.top;
    return Obx(
      () => dataPengajuanController.isLoading.value
          ? const ShimmerHomePage()
          : ratingCabangController.isLoading.value
              ? const ShimmerHomePage()
              : dataCabangController.isLoading.value
                  ? const ShimmerHomePage()
                  : posisiPengajuanController.isLoading.value
                      ? const ShimmerHomePage()
                      : Scaffold(
                          backgroundColor: mBgColor,
                          appBar: _buildAppBar(heightStatusBar),
                          body: _buildBody(),
                        ),
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
            circleAvatarWidget(name, 21),
          ],
        ),
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shortenLastName(name),
            style: textBoldLightLarge,
          ),
          const SizedBox(height: 3),
          Text(
            bagian == "null" ? jabatan : "$jabatan $bagian",
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Color(0xFFEBEBEB),
            ),
          )
        ],
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog().alertdialog(context);
                    });
              },
              child: const Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.white,
              ),
            ))
      ],
      automaticallyImplyLeading: true,
      leadingWidth: Get.width * 0.28,
      elevation: 0,
    );
  }

  Container _buildBody() {
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
          RefreshIndicator(
            onRefresh: () {
              return refresh();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
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
                      role == pincab
                          ? Column(
                              children: [
                                spaceHeightMedium,
                                _posisiPengajuan(),
                              ],
                            )
                          : const SizedBox(),
                      filterCabang != "Semua cabang"
                          ? Column(
                              children: [
                                spaceHeightMedium,
                                _posisiPengajuan(),
                              ],
                            )
                          : const SizedBox(),
                      filterRating == "Semua cabang"
                          ? role == pincab
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    spaceHeightMedium,
                                    _ratingCabang(),
                                  ],
                                )
                          : Container(),
                      spaceHeightMedium,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _formDate() {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: GridView.count(
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal awal",
                  style: textBoldDarkMedium,
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (defaultTargetPlatform == deviceAndroid) {
                      final date = await datePicker(context, DateTime.now());
                      if (mounted) {
                        setState(() {
                          ratingCabangController.firstDateFilter = date!;
                        });
                      }
                    } else if (defaultTargetPlatform == deviceIos) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                          height: 500,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 400,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        ratingCabangController.firstDateFilter =
                                            val;
                                        // print(val);
                                        // firstDate = val;
                                      });
                                    }),
                              ),

                              // Close the modal
                              CupertinoButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: decorationFormTgl(),
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 21,
                                color: mPrimaryColor,
                              ),
                              spaceWidthVerySmall,
                              Text(
                                ratingCabangController.firstDateFilter
                                    .simpleDate(),
                                style: textBoldDarkMedium,
                              ),
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
          SizedBox(
            width: double.infinity,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal akhir",
                  style: textBoldDarkMedium,
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (defaultTargetPlatform == deviceAndroid) {
                      final date = await datePicker(context, DateTime.now());
                      if (mounted) {
                        setState(() {
                          ratingCabangController.lastDateFilter = date!;
                        });
                      }
                    } else if (defaultTargetPlatform == deviceIos) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                          height: 500,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 400,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        ratingCabangController.lastDateFilter =
                                            val;
                                      });
                                    }),
                              ),

                              // Close the modal
                              CupertinoButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: decorationFormTgl(),
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 21,
                                color: mPrimaryColor,
                              ),
                              spaceWidthVerySmall,
                              Text(
                                // dateTimeLast != null
                                //     ? "${dateTimeLast!.day}-${dateTimeLast!.month}-${dateTimeLast!.year}"
                                //     : 'dd-mm-yyyy',
                                ratingCabangController.lastDateFilter
                                    .simpleDate()
                                    .toString(),
                                style: textBoldDarkMedium,
                              ),
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
        ],
      ),
    );
  }

  Column _formCabang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cabang", style: textBoldDarkMedium),
        const SizedBox(height: 5),
        SizedBox(
          height: 35,
          child: DropdownButtonFormField(
            isDense: true,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            value: valueCabang,
            hint: const Text("Semua cabang", style: textBoldDarkMedium),
            onChanged: ((value) {
              if (mounted) {
                setState(() {
                  valueCabang = value as String;
                });
              }
            }),
            items: dataCabangController.dataCabangModel?.data.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.cabang,
                  style: textBoldDarkMedium,
                ),
                onTap: () {
                  filterCodeCabang = item.kodeCabang;
                },
                value: item.cabang,
              );
            }).toList(),
          ),
        ),
      ],
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Periode : ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: mPrimaryColor,
                        ),
                      ),
                      Text(
                        "${ratingCabangController.firstDateFilter.fullDate()} s/d ${ratingCabangController.lastDateFilter.fullDate()}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Cabang : ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: mPrimaryColor,
                        ),
                      ),
                      Text(
                        role == administrator || role == spi || role == ku
                            ? filterCabang!
                            : dataPengajuanController
                                .dataPengajuanModel!.data[0].cabang,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
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
                        if (mounted) {
                          setState(() {
                            if (typeFilter == true) {
                              typeFilter = false;
                            } else {
                              typeFilter = true;
                            }
                          });
                        }
                      },
                      child: typeFilter
                          ? const Icon(
                              Icons.arrow_drop_up,
                              size: 35,
                            )
                          : const Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
          typeFilter
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceHeightSmall,
                    Container(
                      width: Get.width,
                      height: 1,
                      color: mGreyVeryLightColor,
                    ),
                    spaceHeightSmall,
                    _formDate(),
                    role == administrator || role == spi || role == ku
                        ? _formCabang()
                        : Container(),
                    spaceHeightMedium,
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(20), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                if (mounted) {
                                  typeFilter = false;
                                  filterCabang = valueCabang == null
                                      ? "Semua cabang"
                                      : valueCabang!;
                                  filterRating = valueCabang == null
                                      ? "Semua cabang"
                                      : valueCabang!;
                                  if (role == administrator ||
                                      role == spi ||
                                      role == ku ||
                                      role == direksi) {
                                    dataPengajuanController.kodeCabang =
                                        filterCodeCabang;
                                  } else {
                                    dataPengajuanController.kodeCabang =
                                        kodeCabang;
                                  }
                                  print("kodeCabang $filterCodeCabang");
                                }
                                ratingCabangController.getDataRating();
                                dataPengajuanController.getDataPengajuan();
                                posisiPengajuanController.getPosisiPengajuan();
                                print("filterCodeCabang 2 $filterCabang");
                                print("kodeCabang 2 $kodeCabang");
                                // ratingCabangController.isLoading.value ??
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return Transform.scale(
                                //           scale: 3,
                                //           child: Center(
                                //             child: CircularProgressIndicator(
                                //               valueColor:
                                //                   AlwaysStoppedAnimation<Color>(
                                //                       Colors.white),
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                              },
                              child: const Text(
                                "FILTER",
                                style: textBoldLightMedium,
                              ),
                            ),
                          ),
                          filterCabang == "Semua cabang"
                              ? Container()
                              : spaceWidthSmall,
                          filterCabang == "Semua cabang"
                              ? Container()
                              : Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFE5E4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {
                                      if (mounted) {
                                        setState(() {
                                          filterRating = "Semua cabang";
                                          filterCabang = "Semua cabang";
                                          dataPengajuanController.kodeCabang =
                                              null;
                                          valueCabang = null;
                                          typeFilter = false;
                                        });
                                      }
                                      ratingCabangController.getDataRating();
                                      dataPengajuanController
                                          .getDataPengajuan();
                                      posisiPengajuanController
                                          .getPosisiPengajuan();
                                      print("filterCodeCabang 2 $filterCabang");
                                      print("kodeCabang 2 $kodeCabang");
                                    },
                                    child: const Text(
                                      "Reset",
                                      style: TextStyle(color: mPrimaryColor),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Container _dataPengajuan() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          shadowMedium,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Pengajuan",
              style: textBoldDarkLarge,
            ),
            spaceHeightLarge,
            pieChart(
              context,
              {
                'Disetujui': dataPengajuanController.kodeCabang == null
                    ? ratingCabangController.ratingCabangModel!.totalDisetujui
                        .toDouble()
                    : double.parse(
                        "${dataPengajuanController.dataPengajuanModel?.totalDisetujui}",
                      ),
                'Ditolak': dataPengajuanController.kodeCabang == null
                    ? ratingCabangController.ratingCabangModel!.totalDitolak
                        .toDouble()
                    : double.parse(
                        "${dataPengajuanController.dataPengajuanModel?.totalDitolak}",
                      ),
                'On Progress': dataPengajuanController.kodeCabang == null
                    ? ratingCabangController.ratingCabangModel!.totalDiproses
                        .toDouble()
                    : double.parse(
                        "${dataPengajuanController.dataPengajuanModel?.totalDiproses}",
                      ),
              },
              colorListData,
              "${dataPengajuanController.totalPengajuan}",
            ),
            spaceHeightSmall,
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                legendChart("Disetujui", mGreenFlatColor),
                legendChart("Ditolak", mPrimaryColor),
                legendChart("On Progress", mYellowColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _posisiPengajuan() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          shadowMedium,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Posisi Pengajuan",
              style: textBoldDarkLarge,
            ),
            spaceHeightLarge,
            posisiPengajuanController.posisiPengajuanModel!.data.isEmpty
                ? Container()
                : pieChart(
                    context,
                    {
                      "Pincab": double.parse(
                        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pincab}",
                      ),
                      "PBP": double.parse(
                        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pbp}",
                      ),
                      "PBO": double.parse(
                        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pbo}",
                      ),
                      "Penyelia": double.parse(
                        "${posisiPengajuanController.posisiPengajuanModel?.data[0].penyelia}",
                      ),
                      "Staff": double.parse(
                        "${posisiPengajuanController.posisiPengajuanModel?.data[0].staff}",
                      ),
                    },
                    colorListPosisi,
                    posisiPengajuanController.totalPosisi.toString(),
                  ),
            spaceHeightSmall,
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                legendChart("Pincab", mBlueFlatColor),
                legendChart("PBP", mAmberFlatColor),
                legendChart("PBO", mPurpleLightColor),
                legendChart("Penyelia", mPinkLightColor),
                legendChart("Staff", mBlueLightColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _ratingCabang() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          shadowMedium,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ranking Cabang",
                  style: textBoldDarkLarge,
                ),
                Row(
                  children: [
                    legendChart("Tertinggi", mGreenFlatColor),
                    spaceWidthSmall,
                    legendChart("Terendah", mPrimaryColor),
                  ],
                )
              ],
            ),
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: ratingCabangController
                              .ratingCabangModel?.data.tertinggi.length ??
                          0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: mGreyVeryLightColor, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 33,
                                    height: 33,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: mGreenFlatColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${ratingCabangController.ratingCabangModel?.data.tertinggi[index].kodeCabang}",
                                        style: textBoldLightMedium,
                                      ),
                                    ),
                                  ),
                                  spaceWidthVerySmall,
                                  Text(
                                    "${ratingCabangController.ratingCabangModel?.data.tertinggi[index].cabang}",
                                    style: textBoldDarkSmall,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "${ratingCabangController.ratingCabangModel?.data.tertinggi[index].total}",
                                  style: textBoldDarkSmall,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                spaceWidthVerySmall,
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: ratingCabangController
                            .ratingCabangModel?.data.terendah.length ??
                        0,
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        height: 33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: mGreyVeryLightColor, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 33,
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: mPrimaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${ratingCabangController.ratingCabangModel?.data.terendah[index].kodeCabang}",
                                      style: textBoldLightMedium,
                                    ),
                                  ),
                                ),
                                spaceWidthVerySmall,
                                Text(
                                  "${ratingCabangController.ratingCabangModel?.data.terendah[index].cabang}",
                                  style: textBoldDarkSmall,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "${ratingCabangController.ratingCabangModel?.data.terendah[index].total}",
                                style: textBoldDarkSmall,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

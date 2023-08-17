import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/skema_kredit_controller.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_data_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_skema_kredit.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_skema_kredit_whith_name.dart';
import 'package:los_mobile/src/futures/home/view/shimmer_home_page.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/dialog/my_alert_dialog.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_bottom_navigation.dart';
import 'package:los_mobile/src/widgets/my_circle_avatar.dart';
import 'package:los_mobile/src/widgets/date/my_date_picker_android.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
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
  DataCabangController dataCabangController = Get.put(DataCabangController());
  DataPengajuanController dataPengajuanController =
      Get.put(DataPengajuanController());
  RatingCabangController ratingCabangController =
      Get.put(RatingCabangController());
  PosisiPengajuanController posisiPengajuanController =
      Get.put(PosisiPengajuanController());
  CircleAvatarWidget circleAvatarWidget = Get.put(CircleAvatarWidget());
  SkemaKreditController skemaKreditController =
      Get.put(SkemaKreditController());
  PreferensUser preferensUser = Get.put(PreferensUser());

  String name = "";
  String jabatan = "";
  String bagian = "";
  String role = "";
  String? valueCodeCabang;
  String? valueCabang;
  String? valueSkemaKredit;
  bool typeFilter = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  totalPengajuan() {}

  void getUser() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = "${spref.getString("name")}";
      jabatan = "${spref.getString("jabatan")}";
      bagian = "${spref.getString("bagian")}";
      role = "${spref.getString("role")}";
    });
  }

  Future refreshAndFilter() async {
    typeFilter = false;
    dataCabangController.selectKodeCabang.value = valueCodeCabang == null
        ? dataCabangController.selectKodeCabang.value
        : valueCodeCabang!;
    dataCabangController.selectCabang.value =
        valueCabang == null ? "Semua cabang" : valueCabang!;
    skemaKreditController.valueSkemaKredit =
        valueSkemaKredit == null || valueSkemaKredit == "-- pilih semua --"
            ? null
            : valueSkemaKredit;

    print(skemaKreditController.totalProsesSkema.value);

    // Skema kredit tanpa nama
    skemaKreditController.totalSkema.value = 0;
    skemaKreditController.totalSkemaPkpj.value = 0;
    skemaKreditController.totalSkemaKkb.value = 0;
    skemaKreditController.totalSkemaUmroh.value = 0;
    skemaKreditController.totalSkemaProkesra.value = 0;
    skemaKreditController.totalSkemaKusuma.value = 0;
    // Skema Kredit dengan nama
    skemaKreditController.totalProsesSkema.value = 0;
    skemaKreditController.totalPengajuanSkema.value = 0;
    skemaKreditController.totalSkemaDisetujui.value = 0;
    skemaKreditController.totalSkemaDitolak.value = 0;
    skemaKreditController.skemaPosisiPincab.value = 0;
    skemaKreditController.skemaPosisiPbp.value = 0;
    skemaKreditController.skemaPosisiPbo.value = 0;
    skemaKreditController.skemaPosisiPenyelia.value = 0;
    skemaKreditController.skemaPosisiStaf.value = 0;
    dataPengajuanController.getDataPengajuan();
    dataCabangController.selectKodeCabang.value.isEmpty
        ? null
        : posisiPengajuanController.getPosisiPengajuan();
    ratingCabangController.getDataRating();
    skemaKreditController.getSkemaKredit();
  }

  Future resetFilter() async {
    // if (mounted) {
    //   setState(() {
    //     dataCabangController.selectCabang.value = "Semua cabang";
    //     dataCabangController.selectKodeCabang.value = "";
    //     typeFilter = false;
    //     skemaKreditController.valueSkemaKredit = null;
    //     valueCabang = null;
    //     valueCodeCabang = null;
    //     valueSkemaKredit = null;

    //     // Skema kredit tanpa nama
    //     skemaKreditController.totalSkema.value = 0;
    //     skemaKreditController.totalSkemaPkpj.value = 0;
    //     skemaKreditController.totalSkemaKkb.value = 0;
    //     skemaKreditController.totalSkemaUmroh.value = 0;
    //     skemaKreditController.totalSkemaProkesra.value = 0;
    //     skemaKreditController.totalSkemaKusuma.value = 0;
    //     // Skema Kredit dengan nama
    //     skemaKreditController.totalSkemaDenganNama.value = 0;
    //     skemaKreditController.totalSkemaDisetujui.value = 0;
    //     skemaKreditController.totalSkemaDitolak.value = 0;
    //     skemaKreditController.skemaPosisiPincab.value = 0;
    //     skemaKreditController.skemaPosisiPbp.value = 0;
    //     skemaKreditController.skemaPosisiPbo.value = 0;
    //     skemaKreditController.skemaPosisiPenyelia.value = 0;
    //     skemaKreditController.skemaPosisiStaf.value = 0;
    //   });
    // }
    // ratingCabangController.getDataRating();
    // dataPengajuanController.getDataPengajuan();
    // posisiPengajuanController.getPosisiPengajuan();
    // skemaKreditController.getSkemaKredit();
    Get.offAll(const MyBottomNavigationBar());
  }

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).viewPadding.top;
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;
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
                          appBar: _buildAppBar(heightStatusBar, isMobile),
                          body: _buildBody(isMobile),
                        ),
    );
  }

  AppBar _buildAppBar(double heightStatusBar, bool isMobile) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      toolbarHeight: defaultTargetPlatform == deviceAndroid
          ? heightStatusBar + 50
          : heightStatusBar + 25,
      titleSpacing: isMobile ? -30 : -140,
      leading: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circleAvatarWidget.circleAvatarWidget(name, 21),
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

  Widget _buildBody(bool isMobile) {
    return Stack(
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
            return refreshAndFilter();
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
                    if (skemaKreditController.valueSkemaKredit != null)
                      Column(
                        children: [
                          spaceHeightMedium,
                          _skemaKreditWithNameSkema(isMobile),
                        ],
                      )
                    else
                      Column(
                        children: [
                          spaceHeightMedium,
                          _skemaKredit(),
                        ],
                      ),
                    role == pincab
                        ? skemaKreditController.valueSkemaKredit != null
                            ? Container()
                            : Column(
                                children: [
                                  spaceHeightMedium,
                                  _posisiPengajuan(),
                                ],
                              )
                        : const SizedBox(),
                    dataCabangController.selectCabang.value == "Semua cabang"
                        ? Container()
                        : skemaKreditController.valueSkemaKredit != null
                            ? Container()
                            : Column(
                                children: [
                                  spaceHeightMedium,
                                  _posisiPengajuan(),
                                ],
                              ),
                    dataCabangController.selectCabang.value == "Semua cabang"
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
                          height: 400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        ratingCabangController.firstDateFilter =
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
                          height: 400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
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
            value: valueCodeCabang,
            hint: Text(dataCabangController.selectCabang.value,
                style: textBoldDarkMedium),
            // hint: Text(
            //     valueCabang == null
            //         ? "Semua cabang"
            //         : dataCabangController.selectCabang.value,
            //     style: textBoldDarkMedium),
            onChanged: ((value) {
              if (mounted) {
                valueCodeCabang = value!;
              }
            }),
            items: dataCabangController.dataCabangModel?.data.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.cabang,
                  style: textBoldDarkMedium,
                ),
                onTap: () {
                  valueCabang = item.cabang;
                },
                value: item.kodeCabang,
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
                        "Skema   : ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: mPrimaryColor,
                        ),
                      ),
                      Text(
                        skemaKreditController.valueSkemaKredit == null
                            ? "Semua skema"
                            : skemaKreditController.valueSkemaKredit!,
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
                            ? dataCabangController.selectCabang.value
                            : "${dataPengajuanController.dataPengajuanModel?.data[0].cabang}",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Skema kredit", style: textBoldDarkMedium),
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
                            value: skemaKreditController.valueSkemaKredit,
                            hint: Text(
                                skemaKreditController.valueSkemaKredit == null
                                    ? "-- pilih semua --"
                                    : skemaKreditController.valueSkemaKredit!,
                                style: textBoldDarkMedium),
                            onChanged: ((value) {
                              if (mounted) {
                                valueSkemaKredit = value as String?;
                              }
                            }),
                            items: skemaKreditController.listSkema.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item,
                                  style: textBoldDarkMedium,
                                ),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                        spaceHeightSmall,
                      ],
                    ),
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
                                refreshAndFilter();
                              },
                              child: const Text(
                                "FILTER",
                                style: textBoldLightMedium,
                              ),
                            ),
                          ),
                          if (dataCabangController.selectCabang.value ==
                              "Semua cabang")
                            Container()
                          else
                            spaceWidthSmall,
                          if (dataCabangController.selectCabang.value ==
                              "Semua cabang")
                            Container()
                          else
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFE5E4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20), // <-- Radius
                                  ),
                                ),
                                onPressed: () {
                                  resetFilter();
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

  Widget _dataPengajuan() {
    return componentDataPengajuan(
      context,
      skemaKreditController.valueSkemaKredit == null
          ? "${dataPengajuanController.totalPengajuan.value}"
          : skemaKreditController.totalPengajuanSkema.value.toString(),
      dataCabangController.selectKodeCabang.value.isEmpty
          ? skemaKreditController.valueSkemaKredit == null
              ? ratingCabangController.ratingCabangModel!.totalDisetujui
                  .toDouble()
              : skemaKreditController.totalSkemaDisetujui.value.toDouble()
          : dataPengajuanController.dataPengajuanModel!.data.isEmpty
              ? 0
              : skemaKreditController.valueSkemaKredit == null
                  ? double.parse(
                      "${dataPengajuanController.dataPengajuanModel?.data[0].totalDisetujui}",
                    )
                  : skemaKreditController.totalSkemaDisetujui.value.toDouble(),
      dataCabangController.selectKodeCabang.value.isEmpty
          ? skemaKreditController.valueSkemaKredit == null
              ? ratingCabangController.ratingCabangModel!.totalDitolak
                  .toDouble()
              : skemaKreditController.totalSkemaDitolak.value.toDouble()
          : dataPengajuanController.dataPengajuanModel!.data.isEmpty
              ? 0
              : skemaKreditController.valueSkemaKredit == null
                  ? double.parse(
                      "${dataPengajuanController.dataPengajuanModel?.data[0].totalDitolak}",
                    )
                  : skemaKreditController.totalSkemaDitolak.value.toDouble(),
      dataCabangController.selectKodeCabang.value.isEmpty
          ? skemaKreditController.valueSkemaKredit == null
              ? ratingCabangController.ratingCabangModel!.totalDiproses
                  .toDouble()
              : skemaKreditController.totalProsesSkema.value.toDouble()
          : dataPengajuanController.dataPengajuanModel!.data.isEmpty
              ? 0
              : skemaKreditController.valueSkemaKredit == null
                  ? double.parse(
                      "${dataPengajuanController.dataPengajuanModel?.data[0].totalDiproses}",
                    )
                  : skemaKreditController.totalProsesSkema.value.toDouble(),
    );
  }

  Widget _skemaKreditWithNameSkema(bool isMobile) {
    return componentSkemaKreditWithNameSkema(
      context,
      skemaKreditController.totalProsesSkema.value.toString(),
      skemaKreditController.skemaPosisiPincab.value.toDouble(),
      skemaKreditController.skemaPosisiPbp.value.toDouble(),
      skemaKreditController.skemaPosisiPbo.value.toDouble(),
      skemaKreditController.skemaPosisiPenyelia.value.toDouble(),
      skemaKreditController.skemaPosisiStaf.value.toDouble(),
      isMobile,
    );
  }

  Container _skemaKredit() {
    return componentSkemaKreditWithoutNameSkema(
      context,
      skemaKreditController.totalSkema.value.toString(),
      skemaKreditController.totalSkemaPkpj.value.toDouble(),
      skemaKreditController.totalSkemaKkb.value.toDouble(),
      skemaKreditController.totalSkemaUmroh.value.toDouble(),
      skemaKreditController.totalSkemaProkesra.value.toDouble(),
      skemaKreditController.totalSkemaKusuma.value.toDouble(),
    );
  }

  Container _posisiPengajuan() {
    return componentPosisiPengajuan(
      context,
      posisiPengajuanController.totalPosisi.value.toString(),
      double.parse(
        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pincab}",
      ),
      double.parse(
        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pbp}",
      ),
      double.parse(
        "${posisiPengajuanController.posisiPengajuanModel?.data[0].pbo}",
      ),
      double.parse(
        "${posisiPengajuanController.posisiPengajuanModel?.data[0].penyelia}",
      ),
      double.parse(
        "${posisiPengajuanController.posisiPengajuanModel?.data[0].staff}",
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

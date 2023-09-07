import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/home/controllers/data_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/data_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/posisi_pengajuan_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/ranking/ranking_skema_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/ranking/rating_cabang_controller.dart';
import 'package:los_mobile/src/futures/home/controllers/skema_kredit_controller.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_data_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_skema_kredit.dart';
import 'package:los_mobile/src/futures/home/view/components/pie_chart_skema_kredit_whith_name.dart';
import 'package:los_mobile/src/futures/home/view/excel/posisi_pengajuan/table_posisi_pengajuan.dart';
import 'package:los_mobile/src/futures/home/view/excel/semua_skema_dan_semua_cabang.dart/table_skema_cabang.dart';
import 'package:los_mobile/src/futures/home/view/excel/skema_with_name/table_skema_with_name.dart';
import 'package:los_mobile/src/futures/home/view/pdf/export_pdf.dart';
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
  var skemaKreditController = Get.put(SkemaKreditController());
  PreferensUser preferensUser = Get.put(PreferensUser());
  RankingSkemaController rankingSkemaController =
      Get.put(RankingSkemaController());

  String name = "";
  String jabatan = "";
  String bagian = "";
  String role = "";
  String subDivisi = "";
  String? valueCodeCabang;
  String? valueCabang;
  String? valueSkemaKredit;
  String? valueExportData;
  bool typeFilter = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  List<dynamic> exportData = [
    'PDF',
    'Excel',
  ];

  totalPengajuan() {}

  void getUser() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = "${spref.getString("name")}";
      jabatan = "${spref.getString("jabatan")}";
      bagian = "${spref.getString("bagian")}";
      role = "${spref.getString("role")}";
      subDivisi = "${spref.getString("sub_divisi")}";
    });
  }

  Future refreshAndFilter() async {
    Get.find<SkemaKreditController>();
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
    // data pengajuan
    dataPengajuanController.totalPengajuan.value = 0;
    dataPengajuanController.totalDisetujui.value = 0;
    dataPengajuanController.totalDitolak.value = 0;
    dataPengajuanController.totalDiproses.value = 0;
    dataPengajuanController.getDataPengajuan();
    dataCabangController.selectKodeCabang.value.isEmpty
        ? null
        : posisiPengajuanController.getPosisiPengajuan();
    // posisiPengajuanController.getPosisiPengajuan();
    dataCabangController.selectKodeCabang.value.isEmpty
        ? ratingCabangController.getDataRating()
        : null;
    skemaKreditController.getSkemaKredit();
    skemaKreditController.valueSkemaKredit == null
        ? null
        : rankingSkemaController.getRankingSkema();
    dataCabangController.typeFilter.value = true;
    setState(() {});
  }

  Future resetFilter() async {
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
                      : skemaKreditController.isLoading.value
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
      titleSpacing: isMobile ? -25 : -140,
      leading: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circleAvatarWidget.circleAvatarWidget(name, 21, 21),
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
    return RefreshIndicator(
        onRefresh: () {
          return refreshAndFilter();
        },
        child: Stack(
          children: [
            ClipPath(
              child: Container(
                height: Get.height * 0.06,
                decoration: const BoxDecoration(
                  color: mPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: AnimatedSize(
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
                        ),
                      ],
                    ),
                  ),
                  spaceHeightMedium,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  _skemaKredit(isMobile),
                                ],
                              ),
                            role == pincab
                                ? skemaKreditController.valueSkemaKredit != null
                                    ? Container()
                                    : Column(
                                        children: [
                                          spaceHeightMedium,
                                          _posisiPengajuan(isMobile),
                                        ],
                                      )
                                : const SizedBox(),
                            dataCabangController.selectCabang.value ==
                                    "Semua cabang"
                                ? Container()
                                : skemaKreditController.valueSkemaKredit != null
                                    ? Container()
                                    : Column(
                                        children: [
                                          spaceHeightMedium,
                                          _posisiPengajuan(isMobile),
                                        ],
                                      ),
                            dataCabangController.selectCabang.value ==
                                    "Semua cabang"
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
                ],
              ),
            )
          ],
        ));
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
                      const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Periode",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                            Text(
                              "Skema",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                            Text(
                              "Cabang",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ratingCabangController.firstDateFilter.fullDate()} s/d ${ratingCabangController.lastDateFilter.fullDate()}",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
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
                          Text(
                            role == administrator ||
                                    role == spi ||
                                    role == ku ||
                                    role == direksi
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
                                setState(() {
                                  valueSkemaKredit = value as String?;
                                });
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
                    role == administrator ||
                            role == spi ||
                            role == ku ||
                            role == direksi
                        ? _formCabang()
                        : Container(),
                    // Export data
                    dataCabangController.typeFilter.value == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceHeightMedium,
                              const Text("Export", style: textBoldDarkMedium),
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
                                  value: valueExportData,
                                  hint: const Text("PDF",
                                      style: textBoldDarkMedium),
                                  onChanged: ((value) {
                                    valueExportData = value as String?;
                                    print(valueExportData);
                                  }),
                                  items: exportData.map((item) {
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
                            ],
                          )
                        : Container(),
                    spaceHeightMedium,
                    _bottomFilter(),
                    dataCabangController.typeFilter.value == true
                        ? _bottomExport()
                        : Container(),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  SizedBox _bottomExport() {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: mPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // <-- Radius
          ),
        ),
        onPressed: () {
          if (valueExportData == null || valueExportData == "PDF") {
            ExportPdf().printPdf();
          } else {
            if (dataCabangController.selectKodeCabang.isNotEmpty) {
              if (skemaKreditController.valueSkemaKredit == null) {
                ExportPosisiPengajuan().excelPosisiPengajuan(); //kesalahan
              } else {
                ExportSkemaWithName().excelSkemaWithName();
              }
            } else {
              if (skemaKreditController.valueSkemaKredit == null) {
                ExportSemuaSkemaDanSemuaCabang()
                    .excelSemuaSkemaDanSemuaCabang();
              } else {
                ExportSkemaWithName().excelSkemaWithName();
              }
            }
            // ExportPosisiPengajuan().excelPosisiPengajuan();
            // ExportSkemaWithName().excelSkemaWithName();
            // ExportSemuaSkemaDanSemuaCabang().excelSemuaSkemaDanSemuaCabang();
          }
        },
        child: const Text(
          "EXPORT",
          style: textBoldLightMedium,
        ),
      ),
    );
  }

  SizedBox _bottomFilter() {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // <-- Radius
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
          if (dataCabangController.selectCabang.value == "Semua cabang")
            Container()
          else
            spaceWidthSmall,
          if (dataCabangController.selectCabang.value == "Semua cabang")
            Container()
          else
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE5E4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
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
    );
  }

  Widget _dataPengajuan() {
    return componentDataPengajuan2(
      skemaKreditController.valueSkemaKredit == null
          ? "${dataPengajuanController.totalPengajuan.value}"
          : skemaKreditController.totalPengajuanSkema.value.toString(),
      skemaKreditController.valueSkemaKredit == null
          ? dataPengajuanController.totalDisetujui.value
          : skemaKreditController.totalSkemaDisetujui.value,
      skemaKreditController.valueSkemaKredit == null
          ? dataPengajuanController.totalDitolak.value
          : skemaKreditController.totalSkemaDitolak.value,
      skemaKreditController.valueSkemaKredit == null
          ? dataPengajuanController.totalDiproses.value
          : skemaKreditController.totalProsesSkema.value,
      // dataCabangController.selectKodeCabang.value.isEmpty
      //     ? skemaKreditController.valueSkemaKredit == null
      //         ? ratingCabangController.ratingCabangModel!.totalDisetujui
      //         : skemaKreditController.totalSkemaDisetujui.value
      //     :
      //     dataPengajuanController.dataPengajuanModel!.data.isEmpty
      //         ? 0
      //         : skemaKreditController.valueSkemaKredit == null
      //             ? int.parse(
      //                 "${dataPengajuanController.dataPengajuanModel?.data[0].totalDisetujui}",
      //               )
      //             : skemaKreditController.totalSkemaDisetujui.value,
      // dataCabangController.selectKodeCabang.value.isEmpty
      //     ? skemaKreditController.valueSkemaKredit == null
      //         ? ratingCabangController.ratingCabangModel!.totalDitolak
      //         : skemaKreditController.totalSkemaDitolak.value
      //     : dataPengajuanController.dataPengajuanModel!.data.isEmpty
      //         ? 0
      //         : skemaKreditController.valueSkemaKredit == null
      //             ? int.parse(
      //                 "${dataPengajuanController.dataPengajuanModel?.data[0].totalDitolak}",
      //               )
      //             : skemaKreditController.totalSkemaDitolak.value,
      // dataCabangController.selectKodeCabang.value.isEmpty
      //     ? skemaKreditController.valueSkemaKredit == null
      //         ? ratingCabangController.ratingCabangModel!.totalDiproses
      //         : skemaKreditController.totalProsesSkema.value
      //     : dataPengajuanController.dataPengajuanModel!.data.isEmpty
      //         ? 0
      //         : skemaKreditController.valueSkemaKredit == null
      //             ? int.parse(
      //                 "${dataPengajuanController.dataPengajuanModel?.data[0].totalDiproses}",
      //               )
      //             : skemaKreditController.totalProsesSkema.value,
    );
  }

  Widget _skemaKreditWithNameSkema(bool isMobile) {
    return componentSkemaKreditWithNameSkema2(
      skemaKreditController.totalProsesSkema.value.toString(),
      skemaKreditController.skemaPosisiPincab.value,
      skemaKreditController.skemaPosisiPbp.value,
      skemaKreditController.skemaPosisiPbo.value,
      skemaKreditController.skemaPosisiPenyelia.value,
      skemaKreditController.skemaPosisiStaf.value,
      isMobile,
    );
  }

  Widget _skemaKredit(bool isMobile) {
    return componentSkemaKreditWithoutNameSkema2(
      skemaKreditController.totalSkema.value.toString(),
      skemaKreditController.totalSkemaPkpj.value,
      skemaKreditController.totalSkemaKkb.value,
      skemaKreditController.totalSkemaUmroh.value,
      skemaKreditController.totalSkemaProkesra.value,
      skemaKreditController.totalSkemaKusuma.value,
      isMobile,
    );
  }

  Widget _posisiPengajuan(bool isMobile) {
    return componentPosisiPengajuan2(
      posisiPengajuanController.totalPosisi.value.toString(),
      posisiPengajuanController.posisiPengajuanModel!.data[0].pincab,
      posisiPengajuanController.posisiPengajuanModel!.data[0].pbp,
      posisiPengajuanController.posisiPengajuanModel!.data[0].pbo,
      posisiPengajuanController.posisiPengajuanModel!.data[0].penyelia,
      posisiPengajuanController.posisiPengajuanModel!.data[0].staff,
      isMobile,
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
            if (skemaKreditController.valueSkemaKredit == null)
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
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: rankingSkemaController
                                .skemaKreditWithNameSkemaModel
                                ?.ranking
                                .tertinggi
                                .length ??
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
                                          "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.tertinggi[index].kodeCabang}",
                                          style: textBoldLightMedium,
                                        ),
                                      ),
                                    ),
                                    spaceWidthVerySmall,
                                    Text(
                                      "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.tertinggi[index].cabang}",
                                      style: textBoldDarkSmall,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.tertinggi[index].total}",
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
                      itemCount: rankingSkemaController
                              .skemaKreditWithNameSkemaModel
                              ?.ranking
                              .terendah
                              .length ??
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
                                      color: mPrimaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.terendah[index].kodeCabang}",
                                        style: textBoldLightMedium,
                                      ),
                                    ),
                                  ),
                                  spaceWidthVerySmall,
                                  Text(
                                    "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.terendah[index].cabang}",
                                    style: textBoldDarkSmall,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "${rankingSkemaController.skemaKreditWithNameSkemaModel?.ranking.terendah[index].total}",
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/widgets/all_widgets.dart';
import 'package:los_mobile/src/widgets/my_border_form.dart';
import 'package:los_mobile/src/widgets/my_legends_chart.dart';
import 'package:los_mobile/src/widgets/my_shadow.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateTime2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String? valueKetPembayaran;

  List ketPembayaranList = [
    'Semua Cabang',
    'Surabaya',
    'Lumajang',
  ];

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

  Future refresh() async {
    setState(() {
      print(1 + 1);
    });
  }

  Map<String, double> dataMap = {
    "Disetujui": 51,
    "Ditolak": 10,
    "On Progress": 21,
  };

  Map<String, double> dataMapPosisi = {
    "Pincab": 51,
    "PBP": 10,
    "PBO": 21,
    "Penyelia": 21,
    "Staff": 21,
  };

  bool typeFilter = false;

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: _BuildAppBar(heightStatusBar),
      body: _BuildBody(),
    );
  }

  AppBar _BuildAppBar(double heightStatusBar) {
    return AppBar(
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
    );
  }

  Container _BuildBody() {
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
                      spaceHeightMedium,
                      _ratingCabang(),
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

  Container _ratingCabang() {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rating Cabang",
                  style: textBoldDarkLarge,
                ),
                Row(
                  children: [
                    legendChart("Disetujui", mGreenFlatColor),
                    spaceWidthSmall,
                    legendChart("Ditolak", mPrimaryColor),
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
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: mGreyVeryLightColor, width: 1),
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
                              child: const Center(
                                child: Text(
                                  "001",
                                  style: textBoldLightMedium,
                                ),
                              ),
                            ),
                            spaceWidthVerySmall,
                            const Text(
                              "Surabaya",
                              style: textBoldDarkSmall,
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "450",
                            style: textBoldDarkSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                spaceWidthSmall,
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: mGreyVeryLightColor, width: 1),
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
                              child: const Center(
                                child: Text(
                                  "024",
                                  style: textBoldLightMedium,
                                ),
                              ),
                            ),
                            spaceWidthVerySmall,
                            const Text(
                              "Surabaya",
                              style: textBoldDarkSmall,
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "450",
                            style: textBoldDarkSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Posisi Pengajuan",
              style: textBoldDarkLarge,
            ),
            spaceHeightLarge,
            PieChart(
              dataMap: dataMapPosisi,
              animationDuration: const Duration(milliseconds: 1000),
              chartLegendSpacing: 30,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorListPosisi,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              emptyColor: Colors.black,
              ringStrokeWidth: 32,
              centerText: "21",
              centerTextStyle: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              legendOptions: const LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: false,
                legendTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                chartValueBackgroundColor: Color(0xFFF8F8F8),
                chartValueStyle: textBoldDarkMedium,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: true,
                decimalPlaces: 0,
              ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Pengajuan",
              style: textBoldDarkLarge,
            ),
            spaceHeightLarge,
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 1000),
              chartLegendSpacing: 30,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorListData,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              emptyColor: Colors.black,
              ringStrokeWidth: 32,
              centerText: "96",
              centerTextStyle: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              legendOptions: const LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: false,
                legendTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                chartValueBackgroundColor: Color(0xFFF8F8F8),
                chartValueStyle: textBoldDarkMedium,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: true,
                decimalPlaces: 0,
              ),
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

  Padding _cardFilter() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
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
                        if (mounted) {
                          setState(() {
                            if (typeFilter == true) {
                              typeFilter = false;
                            } else {
                              typeFilter = true;
                            }
                          });
                        }
                        print(typeFilter);
                      },
                      child: typeFilter
                          ? Icon(
                              Icons.arrow_drop_up,
                              size: 35,
                            )
                          : Icon(
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
                    _formCabang(),
                    spaceHeightMedium,
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Transform.scale(
                                  scale: 3,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ));
                            },
                          );
                        },
                        child: Text(
                          "FILTER",
                          style: textBoldLightMedium,
                        ),
                      ),
                    )
                  ],
                )
              : Container()
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
            value: valueKetPembayaran,
            hint: const Text(
              "Semua Cabang",
              style: textBoldDarkMedium,
            ),
            onChanged: ((value) {
              if (mounted) {
                setState(() {
                  valueKetPembayaran = value as String;
                });
              }
            }),
            items: ketPembayaranList.map((item) {
              return DropdownMenuItem(
                child: Text(
                  "$item".toUpperCase(),
                  style: textBoldDarkMedium,
                ),
                value: item,
              );
            }).toList(),
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
                    final date = await pickerDate();
                    if (date == null) return;
                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                    );
                    if (mounted) {
                      setState(() {
                        dateTime = date;
                      });
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
                                "${dateTime.day}-${dateTime.month}-${dateTime.year}",
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
          Container(
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
                    final date = await pickerDate2();
                    if (date == null) return;
                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                    );
                    if (mounted) {
                      setState(() {
                        dateTime2 = date;
                      });
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
                                "${dateTime2.day}-${dateTime2.month}-${dateTime2.year}",
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

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
  Future<DateTime?> pickerDate2() => showDatePicker(
        context: context,
        initialDate: dateTime2,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
}

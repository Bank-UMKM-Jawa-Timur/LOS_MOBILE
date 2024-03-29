import 'package:community_material_icon/community_material_icon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_mobile/src/futures/exports/view/export.dart';
import 'package:los_mobile/src/futures/home/view/home_commingsoon.dart';
import 'package:los_mobile/src/futures/home/view/home_test.dart';
import 'package:los_mobile/src/widgets/dialog/my_alert_dialog.dart';
import 'package:los_mobile/utils/colors.dart';
import 'package:los_mobile/src/futures/home/view/home_page.dart';
import 'package:los_mobile/src/futures/profile/view/profile_page.dart';
import 'package:los_mobile/utils/preferens_user.dart';
import 'package:los_mobile/utils/role_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  PreferensUser preferensUser = Get.put(PreferensUser());
  String? role;
  ConnectivityResult? connectivityResult;

  static final List _widgetOptions = [
    const HomePage(),
    const Text(
      'Index 1: Business',
    ),
    const ExportPage(),
  ];

  static const List _widgetOptionsComming = [
    HomeCommingsoon(),
    Text(
      'Index 1: Business',
    ),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      return;
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cekRoleUser();
  }

  cekRoleUser() async {
    await SharedPreferences.getInstance();
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      role = preferensUser.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: role == administrator ||
                role == direksi ||
                role == pincab ||
                role == ku
            ? _widgetOptions.elementAt(_selectedIndex)
            : _widgetOptionsComming.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionBottom(context),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            CommunityMaterialIcons.home_outline,
            size: 25,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CommunityMaterialIcons.home_outline,
            size: 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.print_outlined,
            size: 25,
          ),
          label: 'Export',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: mPrimaryColor,
      onTap: _onItemTapped,
    );
  }

  Widget _floatingActionBottom(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 27),
            width: 60,
            height: 60,
            child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    color: mPrimaryColor,
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500.0),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MyAlertDialog().alertdialog(context);
                        });
                    // Get.to(HomeTest());
                  },
                  child: const Icon(
                    Icons.credit_card,
                    size: 27,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Analisa",
            style: TextStyle(fontWeight: FontWeight.w500, color: mPrimaryColor),
          )
        ],
      ),
    );
  }
}

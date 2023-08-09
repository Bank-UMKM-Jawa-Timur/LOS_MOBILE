import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:los_mobile/view/home/home_page.dart';
import 'package:los_mobile/view/profile/profile_page.dart';
import 'package:los_mobile/widgets/Space/widget_space.dart';
import 'package:los_mobile/widgets/colors/theme.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 27),
              width: 55,
              height: 55,
              child: Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      color: WidgetTheme.primaryColor,
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: () {},
                    child: const Icon(
                      Icons.credit_card,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            WidgetSpace().spaceHeight(1),
            const Text(
              "Analisa",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: WidgetTheme.primaryColor),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CommunityMaterialIcons.home_outline,
              size: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(
              CommunityMaterialIcons.home_outline,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              size: 25,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: WidgetTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

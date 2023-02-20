import 'package:badges/badges.dart' as badges;
import 'package:easylifeapp/screens/account_screen.dart';
import 'package:easylifeapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylifeapp/screens/settings_screen.dart';

import '../constants/global_variables.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home ';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomBarborderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text("hello"),
    ),
    const SettingsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 40, 119, 124),
        unselectedItemColor: const Color.fromARGB(255, 48, 145, 137),
        backgroundColor: GlobalVariables.backgroundcolor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectednavbarcolor
                          : GlobalVariables.backgroundcolor,
                      width: bottomBarborderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectednavbarcolor
                        : GlobalVariables.backgroundcolor,
                    width: bottomBarborderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.book),
            ),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectednavbarcolor
                        : GlobalVariables.backgroundcolor,
                    width: bottomBarborderWidth,
                  ),
                ),
              ),
              child: const badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Color.fromARGB(255, 16, 94, 83),
                  padding: EdgeInsets.all(7),
                ),
                badgeContent: Text(
                  '2',
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.favorite_border),
              ),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? GlobalVariables.selectednavbarcolor
                        : GlobalVariables.backgroundcolor,
                    width: bottomBarborderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

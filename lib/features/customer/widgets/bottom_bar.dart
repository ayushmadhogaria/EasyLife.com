import 'package:badges/badges.dart' as badges;
import 'package:easylifeapp/providers/navigation_provider.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/features/account/screens/account_screen.dart';
import 'package:easylifeapp/features/home/screens/home_screen.dart';
import 'package:easylifeapp/features/wishlist/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylifeapp/features/customer/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home ';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double bottomNavBarWidth = 42;
  double bottomBarborderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<NavigationProvider>(context).selectedIndex;
    final userWishlistLen = context.watch<UserProvider>().user.wishlist;
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 40, 119, 124),
        unselectedItemColor: const Color.fromARGB(255, 48, 145, 137),
        backgroundColor: GlobalVariables.backgroundcolor,
        iconSize: 28,
        onTap: (index) {
          context.read<NavigationProvider>().selectedIndex = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 0
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
                    color: page == 1
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
                    color: page == 2
                        ? GlobalVariables.selectednavbarcolor
                        : GlobalVariables.backgroundcolor,
                    width: bottomBarborderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color.fromARGB(255, 16, 94, 83),
                  padding: EdgeInsets.all(7),
                ),
                badgeContent: Text(
                  userWishlistLen.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.favorite_border),
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
                    color: page == 3
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

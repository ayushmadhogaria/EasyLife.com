import 'package:easylifeapp/admin/screens/all_service_screen.dart';
import 'package:easylifeapp/admin/screens/analytics_screen.dart';
import 'package:easylifeapp/admin/screens/appointment_screen.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomBarborderWidth = 5;

  List<Widget> pages = [
    const AllServiceManScreen(),
    const AnalyticsScreen(),
    const AppointmentsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.backgroundcolor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/project_logo.png',
                  width: 120.h,
                  height: 50.h,
                ),
              ),
              const Text(
                'Admin Panel',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 117, 93),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 40, 119, 124),
        unselectedItemColor: Color.fromARGB(255, 48, 145, 137),
        backgroundColor: GlobalVariables.backgroundcolor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //all serviceman lists
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

          //all business analytics
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
              child: const Icon(Icons.analytics_outlined),
            ),
            label: 'Analytics',
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
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: 'Appointments',
          ),
        ],
      ),
    );
  }
}

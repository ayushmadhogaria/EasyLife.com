import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicemanScreen extends StatefulWidget {
  const ServicemanScreen({super.key});

  @override
  State<ServicemanScreen> createState() => _ServicemanScreenState();
}

class _ServicemanScreenState extends State<ServicemanScreen> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomBarborderWidth = 5;

  List<Widget> pages = [
    const Center(
      child: Text("Posts page"),
    ),
    const Center(
      child: Text("Appointments"),
    ),
    const Center(
      child: Text("Settings"),
    ),
    const Center(
      child: Text("Settings"),
    ),
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
        selectedItemColor: const Color.fromARGB(255, 40, 119, 124),
        unselectedItemColor: const Color.fromARGB(255, 48, 145, 137),
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

          //all appointments
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
              child: const Icon(Icons.book_sharp),
            ),
            label: 'Appointments',
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

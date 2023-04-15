import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/account/widgets/app_bar_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bookings.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.loggedinbackgroundcolor,
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
              Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Color.fromARGB(255, 33, 99, 93),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 33, 99, 93),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      body: Column(children: const [AppBarName(), Bookings()]),
    );
  }
}

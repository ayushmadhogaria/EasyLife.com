import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/customer/widgets/settings_body.dart';
import 'package:easylifeapp/features/customer/widgets/settings_information.dart';
import 'package:easylifeapp/features/customer/widgets/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          title: Padding(
            padding: const EdgeInsets.only(left: 110),
            child: Image.asset(
              'assets/project_logo.png',
              width: 120.h,
              height: 50.h,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      body: Column(children: const [
        SettingsInformation(),
        UserInformation(),
        SettingsBody()
      ]),
    );
  }
}

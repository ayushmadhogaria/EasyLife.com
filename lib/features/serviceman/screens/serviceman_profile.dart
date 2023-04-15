import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/serviceman/widgets/serviceman_account.dart';
import 'package:easylifeapp/features/customer/widgets/settings_information.dart';
import 'package:easylifeapp/features/customer/widgets/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicemanProfile extends StatefulWidget {
  const ServicemanProfile({super.key});

  @override
  State<ServicemanProfile> createState() => _ServicemanProfileState();
}

class _ServicemanProfileState extends State<ServicemanProfile> {
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
        ServicemanAccount()
      ]),
    );
  }
}

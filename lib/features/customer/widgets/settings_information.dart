import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsInformation extends StatelessWidget {
  const SettingsInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.buttoncolor,
      ),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 150.w)),
          const Text(
            'Settings  ',
            style: TextStyle(
              color: Color.fromARGB(255, 23, 59, 47),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

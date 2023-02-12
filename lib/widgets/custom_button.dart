import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 70.h, left: 70.h, top: 30.h),
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            gradient: GlobalVariables.buttoncolor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffEEEEEE))
            ]),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}

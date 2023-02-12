import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  const PassCustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon,
      required bool obscureText,
      required Icon suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h, right: 15.h, top: 20.h),
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: const Color.fromARGB(255, 76, 173, 160),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color.fromARGB(255, 255, 255, 255),
            )
          ]),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: hintText,
            icon: icon,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
        validator: (val) {},
      ),
    );
  }
}

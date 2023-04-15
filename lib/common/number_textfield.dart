import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Icon icon;
  const NumberCustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      required this.icon});

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
      child: Theme(
        data: ThemeData(errorColor: Colors.white),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: controller,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5),
              hintStyle: const TextStyle(color: Colors.white),
              hintText: hintText,
              icon: icon,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter the phone number';
            }
            return null;
          },
        ),
      ),
    );
  }
}

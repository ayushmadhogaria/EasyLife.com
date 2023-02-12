import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceManTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const AddServiceManTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.h, right: 5.h, top: 7.h),
      padding: EdgeInsets.only(left: 10.h, right: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Color.fromARGB(255, 182, 223, 223),
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
          controller: controller,
          style: const TextStyle(
              color: Color.fromARGB(255, 54, 83, 73),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          cursorColor: Color.fromARGB(255, 54, 83, 73),
          maxLines: maxLines,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5),
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 54, 83, 73)),
              hintText: hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }
}

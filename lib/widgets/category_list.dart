import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: ListView.builder(
        itemExtent: 74.h,
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImage.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  GlobalVariables.categoryImage[index]['image']!,
                  height: 50.h,
                  width: 40.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(GlobalVariables.categoryImage[index]['title']!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 32, 131, 118),
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
              ),
            ],
          );
        },
      ),
    );
  }
}

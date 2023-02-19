import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailsScreen extends StatefulWidget {
  static const String routeName = '/category-details';
  final String category;
  const CategoryDetailsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
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
              InkWell(
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: GlobalVariables.selectednavbarcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  'Book ${widget.category}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 61, 117, 93),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/project_logo.png',
                  width: 80.h,
                  height: 40.h,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.topLeft,
          child: Text(
            'Hire professional ${widget.category} For Better Lifestyle',
            style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 61, 117, 93),
                fontWeight: FontWeight.w400),
          ),
        )
      ]),
    );
  }
}

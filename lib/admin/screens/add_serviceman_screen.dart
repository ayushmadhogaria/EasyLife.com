import 'dart:io';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/widgets/add_serviceman_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceManScreen extends StatefulWidget {
  static const String routeName = '/add-serviceman';
  const AddServiceManScreen({super.key});

  @override
  State<AddServiceManScreen> createState() => _AddServiceManScreenState();
}

class _AddServiceManScreenState extends State<AddServiceManScreen> {
  final TextEditingController serviceManNameController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController shiftController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String category = 'Maid';
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    serviceManNameController.dispose();
    descriptionController.dispose();
    salaryController.dispose();
    shiftController.dispose();
    timeController.dispose();
    numberController.dispose();
  }

  List<String> serviceCategories = [
    'Maid',
    'Driver',
    'Cook',
    'BabySitter',
    'OldAgeCare'
  ];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

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
                onTap: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(left: 60.0),
                child: Text(
                  'Add ServiceMan',
                  style: TextStyle(
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
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                                color: GlobalVariables.unselectednavbarcolor,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select ServiceMan Images/certifications',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 23, 59, 47),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              AddServiceManTextField(
                controller: serviceManNameController,
                hintText: 'ServiceMan Name ',
              ),
              AddServiceManTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              AddServiceManTextField(
                controller: salaryController,
                hintText: 'Salary',
              ),
              AddServiceManTextField(
                controller: numberController,
                hintText: 'Phone Number',
              ),
              AddServiceManTextField(
                controller: shiftController,
                hintText: 'Shift',
              ),
              AddServiceManTextField(
                controller: timeController,
                hintText: 'Work Time',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: 370,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: serviceCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 54, 83, 73),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin:
                      EdgeInsets.only(right: 50.h, left: 50.h, bottom: 10.h),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: GlobalVariables.buttoncolor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ]),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                onTap: () {},
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

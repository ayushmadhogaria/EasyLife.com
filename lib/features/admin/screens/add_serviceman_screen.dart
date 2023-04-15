import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easylifeapp/features/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/common/add_serviceman_textfield.dart';
import 'package:easylifeapp/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String category = 'Maid';
  String shift = 'Morning-\n7am to 12pm';
  String time = 'Part-Time';
  List<File> images = [];

  bool isLoading = false;
  final _addServiceManFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    serviceManNameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    salaryController.dispose();
    numberController.dispose();
  }

  List<String> serviceCategories = [
    'Maid',
    'Driver',
    'Cook',
    'BabySitter',
    'OldAgeCare'
  ];
  List<String> workShift = [
    'Morning-\n7am to 12pm',
    'Afternoon-\n12pm to 5pm',
    'Evening\n5pm to 9pm',
    'Any shift\n7am to 9pm',
  ];
  List<String> jobTime = [
    'Part-Time',
    'Full-Time',
  ];

  void registerServiceman() async {
    if (_addServiceManFormKey.currentState!.validate() && images.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await adminServices.registerServiceman(
        context: context,
        name: serviceManNameController.text,
        description: descriptionController.text,
        salary: double.parse(salaryController.text),
        phone: numberController.text,
        address: addressController.text,
        shift: shift,
        time: time,
        category: category,
        images: images,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

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
                onTap: () {
                  Navigator.pop(context);
                },
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
          key: _addServiceManFormKey,
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
                        enableInfiniteScroll: false,
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
                          width: 380.w,
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
                                'Select ServiceMan Image',
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
                controller: addressController,
                hintText: 'Address ',
              ),
              Container(
                margin: EdgeInsets.only(left: 5.h, right: 5.h, top: 7.h),
                padding: EdgeInsets.only(left: 10.h, right: 10.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: const Color.fromARGB(255, 182, 223, 223),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    ]),
                child: Theme(
                  data: ThemeData(errorColor: Colors.black),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: numberController,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 54, 83, 73),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    cursorColor: const Color.fromARGB(255, 54, 83, 73),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 54, 83, 73),
                        ),
                        hintText: 'Phone number',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              AddServiceManTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 50,
                width: 360,
                child: const Text(
                  'Category',
                  style: TextStyle(
                      color: Color.fromARGB(255, 79, 110, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 360,
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
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 50,
                width: 360,
                child: const Text(
                  'User Type',
                  style: TextStyle(
                      color: Color.fromARGB(255, 79, 110, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 360,
                child: DropdownButton(
                  value: time,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: jobTime.map((String item) {
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
                      time = newVal!;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 50,
                width: 360,
                child: const Text(
                  'Shift',
                  style: TextStyle(
                      color: Color.fromARGB(255, 79, 110, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 360,
                child: DropdownButton(
                  value: shift,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: workShift.map((String item) {
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
                      shift = newVal!;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.h, right: 5.h, top: 7.h),
                padding: EdgeInsets.only(left: 10.h, right: 10.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: const Color.fromARGB(255, 182, 223, 223),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    ]),
                child: Theme(
                  data: ThemeData(errorColor: Colors.black),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: salaryController,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 54, 83, 73),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    cursorColor: const Color.fromARGB(255, 54, 83, 73),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 54, 83, 73),
                        ),
                        hintText: 'Salary',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your salary';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: registerServiceman,
                child: Container(
                  margin: EdgeInsets.only(
                      right: 50.h, left: 50.h, bottom: 10.h, top: 20),
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
                  child: isLoading
                      ? const Center(
                          child: Loader(),
                        )
                      : const Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 83, 73),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

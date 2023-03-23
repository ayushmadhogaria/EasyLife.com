import 'package:bulleted_list/bulleted_list.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutUsScreen extends StatelessWidget {
  final String email = 'ayushmadhogaria3012@gmail.com';
  static const String routeName = '/aboutus-screen';

  String content =
      "EasyLife.com is a mobile application that allows the customers to hire basic household services easily and conviniently, whenever they want rather than finding them in person as it is often time-consuming, impractical, and difficult. The main benefit of this application is that it is a common application platform for both serviceman and customer as both can use the same app based on their distinct roles. \n"
      "Hence, the people wanting to register themselves as serviceman can register themselves to the system easily. As of now, the app will only have services like: maid, cook, driver, babysitter and oldage care services.";

  AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.buttoncolor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Color.fromARGB(255, 57, 68, 63),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(right: 135.0),
                child: Text('About Us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 29, 39, 35),
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Container(
              height: 100,
              color: GlobalVariables.backgroundcolor,
              child: Image.asset('assets/project_logo.png'),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 7)),
          const Text(
            'Our Mission',
            style: TextStyle(
                fontSize: 22,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                height: 2,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 55, 77, 68)),
          ),
          const Text(
            '"Best Living Experience with EasyLife.com"',
            style: TextStyle(
                fontSize: 16,
                height: 2,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 55, 77, 68)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 15, left: 15, bottom: 15),
            child: ReadMoreText(
              content,
              trimLines: 8,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimCollapsedText: "Read More",
              trimExpandedText: " Read Less",
              lessStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 55, 77, 68),
              ),
              moreStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 55, 77, 68),
              ),
              style: const TextStyle(
                  fontSize: 16,
                  height: 2,
                  color: Color.fromARGB(255, 29, 39, 35)),
            ),
          ),
          ExpansionTile(
            title: const Text(
              "Key Points About Us",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 2,
                  color: Color.fromARGB(255, 29, 39, 35)),
            ),
            children: [
              Container(
                height: 200,
                child: SingleChildScrollView(
                    child: Column(
                  children: const [
                    BulletedList(
                      bullet: Icon(Icons.check,
                          color: Color.fromARGB(255, 29, 39, 35)),
                      listItems: [
                        'Customer Satisfaction is our topmost priority',
                        'We work upon your appointments quickly.',
                        'We believe in honesty and integrity in our services.',
                        'Just Search and Book appointment for quality lifestyle.'
                      ],
                      style: TextStyle(
                          fontSize: 14,
                          height: 2,
                          color: Color.fromARGB(255, 29, 39, 35)),
                    ),
                  ],
                )),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 30),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        GlobalVariables.unselectednavbarcolor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: GlobalVariables.unselectednavbarcolor))),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            height: 150,
                            decoration: const BoxDecoration(
                                color: GlobalVariables.backgroundcolor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Contact Us',
                                      style: TextStyle(
                                          fontSize: 18,
                                          height: 2,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 55, 77, 68)),
                                    ),
                                    InkWell(
                                      child: const Icon(
                                        Icons.close,
                                        color: Color.fromARGB(255, 57, 68, 63),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 20),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch('tel: +977-9808185333');
                                      },
                                      child: const Text(
                                        '  +977-9808185333',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 55, 77, 68)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 30),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.email,
                                      size: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final Uri emailLaunchUri = Uri(
                                          scheme: 'mailto',
                                          path: email,
                                        );
                                        final url = 'mailto:$email';
                                        if (await canLaunchUrl(
                                            emailLaunchUri)) {
                                          await canLaunchUrl(emailLaunchUri);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: const Text(
                                        '   ayushmadhogaria3012@gmail.com',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 55, 77, 68)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        });
                  },
                  child: const Text('Contact Us')),
            ),
          ),
        ],
      )),
    );
  }
}

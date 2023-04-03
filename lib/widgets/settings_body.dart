import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/screens/about_us_screen.dart';
import 'package:easylifeapp/screens/login_screen.dart';
import 'package:easylifeapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});
  final String email = 'ayushmadhogaria3012@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 200.h,
            decoration: BoxDecoration(
                gradient: GlobalVariables.buttoncolor,
                borderRadius: BorderRadius.circular(10)),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            height: 200,
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
                                      Icons.message,
                                      size: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // ignore: deprecated_member_use
                                        launch('sms: +977-9808185333');
                                      },
                                      child: const Text(
                                        '  Send SMS',
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
                                    left: 20.0, right: 20, top: 20),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // ignore: deprecated_member_use
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
                                    left: 20.0, right: 20, top: 20),
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
                  leading: const Icon(
                    Icons.headphones,
                    size: 30,
                  ),
                  iconColor: const Color.fromARGB(255, 23, 59, 47),
                  title: Wrap(
                    spacing: 70,
                    children: const [
                      Text(
                        'Help and Support',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 23, 59, 47)),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 15, color: Color.fromARGB(255, 23, 59, 47)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  leading: const Icon(
                    Icons.details_outlined,
                    size: 30,
                  ),
                  iconColor: const Color.fromARGB(255, 23, 59, 47),
                  title: Wrap(
                    spacing: 70,
                    children: const [
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 23, 59, 47)),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 15, color: Color.fromARGB(255, 23, 59, 47)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AboutUsScreen.routeName);
                  },
                  leading: const Icon(
                    Icons.info_rounded,
                    size: 30,
                  ),
                  iconColor: const Color.fromARGB(255, 23, 59, 47),
                  title: Wrap(
                    spacing: 70,
                    children: const [
                      Text(
                        'About Us',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 23, 59, 47)),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 15, color: Color.fromARGB(255, 23, 59, 47)),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                const Color.fromARGB(255, 233, 250, 244),
                            title: const Text(
                              "Are you sure to log out?",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 23, 59, 47)),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 23, 59, 47)),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    await AuthService().logOut(context);
                                    // ignore: use_build_context_synchronously
                                    context.read<UserProvider>().logout();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.routeName,
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 23, 59, 47)),
                                  )),
                            ],
                          );
                        });
                  },
                  leading: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  iconColor: const Color.fromARGB(255, 26, 43, 37),
                  title: Wrap(
                    spacing: 70,
                    children: const [
                      Text(
                        'Log Out ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 23, 59, 47),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color.fromARGB(255, 23, 59, 47),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

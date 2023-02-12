import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 300.h,
            decoration: BoxDecoration(
                gradient: GlobalVariables.buttoncolor,
                borderRadius: BorderRadius.circular(10)),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  leading: const Icon(
                    Icons.book,
                    size: 30,
                  ),
                  iconColor: Color.fromARGB(255, 23, 59, 47),
                  title: Wrap(
                    spacing: 160,
                    children: const [
                      Text(
                        'View appointments',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 23, 59, 47)),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color.fromARGB(255, 23, 59, 47),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  leading: const Icon(
                    Icons.favorite_border_outlined,
                    size: 30,
                  ),
                  iconColor: Color.fromARGB(255, 23, 59, 47),
                  title: Wrap(
                    spacing: 120,
                    children: const [
                      Text(
                        'View wishlist',
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
                    Icons.headphones,
                    size: 30,
                  ),
                  iconColor: Color.fromARGB(255, 23, 59, 47),
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
                  iconColor: Color.fromARGB(255, 23, 59, 47),
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
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  leading: const Icon(
                    Icons.info_rounded,
                    size: 30,
                  ),
                  iconColor: Color.fromARGB(255, 23, 59, 47),
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
                                  onPressed: () => {
                                        Navigator.pushNamed(
                                            context, LoginScreen.routeName),
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
                  iconColor: Color.fromARGB(255, 23, 59, 47),
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

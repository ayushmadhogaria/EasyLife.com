import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarName extends StatelessWidget {
  const AppBarName({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: GlobalVariables.backgroundcolor,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: 'Welcome,  ',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 16, 94, 83),
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: user.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 16, 94, 83),
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ])),
        ],
      ),
    );
  }
}

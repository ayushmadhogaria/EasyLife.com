import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: 130,
        decoration: const BoxDecoration(
          gradient: GlobalVariables.buttoncolor,
        ),
        child: ListView(
          children: [
            const Text(
              "Your Information",
              textAlign: TextAlign.center,
              style: TextStyle(
                  decorationThickness: 2,
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 23, 59, 47)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  decorationThickness: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 23, 59, 47)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  decorationThickness: 2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 23, 59, 47)),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                child: Text(
                  user.phone,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.75,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 23, 59, 47)),
                ),
                // ignore: deprecated_member_use
                onTap: () => launch('tel:${user.phone}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressDetail extends StatelessWidget {
  const AddressDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: GlobalVariables.backgroundcolor,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 27,
            color: Color.fromARGB(255, 63, 100, 84),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                ' Your address - ${user.address} ',
                style: const TextStyle(
                  color: Color.fromARGB(255, 16, 94, 83),
                  fontSize: 15.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 3,
            ),
            child: Icon(
              Icons.arrow_drop_down,
              size: 28,
              color: Color.fromARGB(255, 16, 94, 83),
            ),
          ),
        ],
      ),
    );
  }
}

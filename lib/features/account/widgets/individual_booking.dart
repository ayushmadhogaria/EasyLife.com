import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';

class IndividualBooking extends StatelessWidget {
  final String image;

  const IndividualBooking({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: GlobalVariables.selectednavbarcolor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 182, 219, 204),
        ),
        child: Container(
          width: 180,
          height: 150,
          padding: const EdgeInsets.all(5),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}

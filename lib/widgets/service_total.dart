import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceTotal extends StatelessWidget {
  const ServiceTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.wishlist
        .map((e) => sum += e['duration'] * e['serviceman']['salary'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        const Text(
          'Estimated Total  | ',
          style: const TextStyle(
              color: Color.fromARGB(255, 16, 94, 83), fontSize: 18),
        ),
        Text(
          '\Rs. $sum  ',
          style: const TextStyle(
              color: Color.fromARGB(255, 16, 94, 83),
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
      ]),
    );
  }
}

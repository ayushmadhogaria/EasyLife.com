import 'package:flutter/material.dart';

// String uri = 'http://192.168.1.108:3000';
String uri = 'http://192.168.1.69:3000';

class GlobalVariables {
  static const backgroundcolor = Color.fromARGB(255, 217, 254, 241);
  static const loggedinbackgroundcolor = Color.fromARGB(255, 234, 245, 241);
  static const selectednavbarcolor = Color.fromARGB(255, 87, 158, 127);
  static const unselectednavbarcolor = Color.fromARGB(255, 98, 128, 115);
  static const buttoncolor = LinearGradient(colors: [
    Color.fromARGB(255, 165, 206, 202),
    Color.fromARGB(255, 80, 160, 156)
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static const List<String> carouselImages = [
    'https://images.unsplash.com/photo-1516862523118-a3724eb136d7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHJpdmVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://media.istockphoto.com/id/1364946137/photo/businessman-holding-and-showing-the-best-quality-assurance-with-golden-five-stars-for.jpg?b=1&s=170667a&w=0&k=20&c=4I8ctr_z1np5DiincV1VFlMjwwEyc-wHb_0gWElH6DU=',
    'https://media.istockphoto.com/id/1396552165/photo/custodian-janitor-pushing-cleaning-cart-down-hallway-shadow-focus-on-shadow-digital-composite.jpg?b=1&s=170667a&w=0&k=20&c=oCf0ERgj8t0ihcD1Ck9JPXpKalnDWiCr7zSqc4pccs4=',
    'https://images.unsplash.com/photo-1489760176169-fd3d32805239?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFieXNpdHRlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://media.istockphoto.com/id/1177288254/photo/red-haired-caregiver-supporting-woman-with-crutches.jpg?s=612x612&w=0&k=20&c=qE0OMe_oys8D8hhAWdnAwtdPyJt0uhyGXOc4jKU6NWg=',
    'https://media.istockphoto.com/id/887944890/photo/unrecognizable-woman-stirring-soup-in-a-saucepan-while-making-lunch.jpg?s=612x612&w=0&k=20&c=4DBTtI3-82DvlXKQ9AxmvT8Y8sYTPy_TURJVVMqLGUc=',
  ];

  static const List<Map<String, String>> categoryImage = [
    {
      'title': 'Maid',
      'image': 'assets/maid.png',
    },
    {
      'title': 'Driver',
      'image': 'assets/driver.png',
    },
    {
      'title': 'Cook',
      'image': 'assets/cook.png',
    },
    {
      'title': 'BabySitter',
      'image': 'assets/babysitter.png',
    },
    {
      'title': 'OldAgeCare',
      'image': 'assets/oldage.png',
    },
  ];
}

import 'package:easylifeapp/admin/screens/add_serviceman_screen.dart';
import 'package:easylifeapp/screens/home_screen.dart';
import 'package:easylifeapp/screens/login_screen.dart';
import 'package:easylifeapp/screens/registration_screen.dart';
import 'package:easylifeapp/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegistrationScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddServiceManScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddServiceManScreen(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page doesn't exists."),
                ),
              ));
  }
}

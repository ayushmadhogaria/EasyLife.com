import 'package:easylifeapp/admin/screens/add_serviceman_screen.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/address_screen.dart';
import 'package:easylifeapp/screens/appointment_details.dart';
import 'package:easylifeapp/screens/category_detail_screen.dart';
import 'package:easylifeapp/screens/home_screen.dart';
import 'package:easylifeapp/screens/login_screen.dart';
import 'package:easylifeapp/screens/registration_screen.dart';
import 'package:easylifeapp/screens/search_screen.dart';
import 'package:easylifeapp/screens/serviceman_detail_screen.dart';
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
    case CategoryDetailsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDetailsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ServicemanDetailScreen.routeName:
      var serviceman = routeSettings.arguments as Serviceman;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ServicemanDetailScreen(
          serviceman: serviceman,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case AppointmentDetailScreen.routeName:
      var appointment = routeSettings.arguments as Appointment;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppointmentDetailScreen(
          appointment: appointment,
        ),
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

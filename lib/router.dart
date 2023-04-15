import 'package:easylifeapp/features/admin/screens/add_serviceman_screen.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/features/commons/screens/about_us_screen.dart';
import 'package:easylifeapp/features/address/screens/address_screen.dart';
import 'package:easylifeapp/features/appointment_detail/appointment_details.dart';
import 'package:easylifeapp/features/home/screens/category_detail_screen.dart';
import 'package:easylifeapp/features/home/screens/home_screen.dart';
import 'package:easylifeapp/features/auth/screens/login_screen.dart';
import 'package:easylifeapp/features/commons/screens/map_screen.dart';
import 'package:easylifeapp/features/auth/screens/registration_screen.dart';
import 'package:easylifeapp/features/search_serviceman/screens/search_screen.dart';
import 'package:easylifeapp/features/serviceman_detail/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/features/commons/screens/terms_condition_screen.dart';
import 'package:easylifeapp/features/customer/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case AboutUsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AboutUsScreen(),
      );
    case TermsAndConditionPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TermsAndConditionPage(),
      );
    case MapScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MapScreen(),
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

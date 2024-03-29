// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:easylifeapp/features/admin/screens/admin_screen.dart';
import 'package:easylifeapp/constants/error_handler.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/models/user.dart';
import 'package:easylifeapp/providers/navigation_provider.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/features/serviceman/screens/serviceman_screen.dart';
import 'package:easylifeapp/features/customer/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';

//register user

class AuthService {
  void registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String type,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        type: type,
        phone: phone,
        address: '',
        token: '',
        wishlist: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Proceed to login with the same credentials.',
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //login user
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          final user = context.read<UserProvider>().user;

          if (user.type.toLowerCase() == 'admin') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AdminScreen()),
                (route) => false);
          } else if (user.type.toLowerCase() == 'customer') {
            context.read<NavigationProvider>().selectedIndex = 0;
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          } else {
            context.read<NavigationProvider>().selectedIndex = 0;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ServicemanScreen()),
              (route) => false,
            );
          }
        },
        //onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //getting user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //logout user
  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove('x-auth-token');
      return;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

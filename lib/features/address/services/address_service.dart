import 'dart:convert';
import 'package:easylifeapp/constants/error_handler.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/models/user.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  //save user address
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //book appointments
  Future<void> bookAppointment(
      {required BuildContext context,
      required String name,
      required String userContact,
      required String address,
      required String appointDate,
      required String appointTime,
      required double totalAmount,
      required}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/appointment'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'wishlist': userProvider.user.wishlist,
            'address': address,
            'userName': name,
            'userContact': userContact,
            'totalAmount': totalAmount,
            'appointDate': appointDate,
            'appointTime': appointTime,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Your appointment have been placed! Kindly check the status for updates.');
          User user = userProvider.user.copyWith(
            wishlist: [],
            name: jsonDecode(res.body)['userName'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//delete appointment
  void deleteAppointment({
    required BuildContext context,
    required Appointment appointment,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-appointment'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': appointment.id,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

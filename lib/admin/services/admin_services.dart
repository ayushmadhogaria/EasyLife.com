import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:easylifeapp/constants/error_handler.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/models/transaction.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  Future<void> registerServiceman({
    required BuildContext context,
    required String name,
    required String description,
    required String address,
    required double salary,
    required String phone,
    required String shift,
    required String time,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dw1wvvnkx', 'x8g0fbng');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Serviceman serviceman = Serviceman(
        name: name,
        description: description,
        salary: salary,
        address: address,
        phone: phone,
        shift: shift,
        time: time,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-serviceman'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: serviceman.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Serviceman Registered Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //fetch data of all the serviceman
  Future<List<Serviceman>> fetchAllServiceman(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Serviceman> servicemanList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-serviceman'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            servicemanList.add(
              Serviceman.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return servicemanList;
  }

//delete serviceman
  void deleteServiceman(
      {required BuildContext context,
      required Serviceman serviceman,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-serviceman'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': serviceman.id,
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

  //fetch data of all the serviceman
  Future<List<Appointment>> fetchAllAppointments(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Appointment> appointmentList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-appointments'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            appointmentList.add(
              Appointment.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return appointmentList;
  }

//change appointment status
  void changeAppointmentStatus({
    required BuildContext context,
    required int status,
    required Appointment appointment,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-appointment-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': appointment.id,
            'status': status,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//getting the category wise earnings
  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Transaction> transaction = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          transaction = [
            Transaction('Maid', response['maidEarnings']),
            Transaction('Driver', response['driverEarnings']),
            Transaction('Cook', response['cookEarnings']),
            Transaction('BabySitter', response['babySitterEarnings']),
            Transaction('OldAgeCare', response['oldageCareEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'transaction': transaction,
      'totalEarnings': totalEarning,
    };
  }
}

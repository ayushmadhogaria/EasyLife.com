import 'dart:convert';
import 'package:easylifeapp/constants/error_handler.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Serviceman>> fetchCategoryServiceman({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Serviceman> servicemanList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/serviceman?category=$category'),
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

  Future<Serviceman> fetchRecommendedServiceman({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Serviceman serviceman = Serviceman(
        name: '',
        description: '',
        salary: 0,
        phone: '',
        address: '',
        shift: '',
        time: '',
        category: '',
        images: []);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/recommended-for-you'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          serviceman = Serviceman.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return serviceman;
  }
}

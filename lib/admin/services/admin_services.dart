import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:flutter/cupertino.dart';

class AdminServices {
  void registerServiceman({
    required BuildContext context,
    required String name,
    required String description,
    required double salary,
    required String phone,
    required String shift,
    required String worktime,
    required String category,
    required List<File> images,
  }) async {
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
        phone: phone,
        shift: shift,
        worktime: worktime,
        category: category,
        images: imageUrls,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

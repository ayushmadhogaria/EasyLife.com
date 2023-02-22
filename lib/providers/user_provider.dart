import 'package:easylifeapp/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    type: '',
    phone: '',
    address: '',
    token: '',
    wishlist: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void serUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

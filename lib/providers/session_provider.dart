import 'package:alumlink_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

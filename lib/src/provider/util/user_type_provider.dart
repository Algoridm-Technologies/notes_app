import 'package:flutter/material.dart';

class UserTypeProvider extends ChangeNotifier {
  //let 0 represent employee 
  //let 1 represent employer
  //let -1 represent no user type
  int _userType = -1;

  int get userType => _userType;

  changeState(int userType) {
    _userType = userType;
    notifyListeners();
  }
}

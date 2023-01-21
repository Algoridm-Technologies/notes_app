import 'package:flutter/material.dart';

class EmployeeNavigationProvider extends ChangeNotifier {
  int _currentPosition = 0;

  int get currentPosition => _currentPosition;

  changePage(int position) {
    _currentPosition = position;
    notifyListeners();
  }
}

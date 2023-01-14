import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentPosition = 0;

  int get currentPosition => _currentPosition;

  changePage(int position) {
    _currentPosition = position;
    notifyListeners();
  }
}

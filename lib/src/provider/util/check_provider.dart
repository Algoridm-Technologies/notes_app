import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  final List<int> _positions = [];
  bool _isChecking = false;

  List<int> get positions => _positions;
  bool get isChecking => _isChecking;

  changeIsChecking(bool isChecking) {
    _isChecking = isChecking;
    notifyListeners();
  }

  addToList(int position) {
    _positions.add(position);
    notifyListeners();
  }

  removeToList(int position) {
    _positions.remove(position);
    notifyListeners();
  }
}

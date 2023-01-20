import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  final List<int> _positions = [];
  bool _isChecking = false;
  int _selected = -1;

  List<int> get positions => _positions;
  bool get isChecking => _isChecking;
  int get selected => _selected;

  changeIsChecking(bool isChecking) {
    _isChecking = isChecking;
    notifyListeners();
  }

  selectTile(int position) {
    _selected = position;
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

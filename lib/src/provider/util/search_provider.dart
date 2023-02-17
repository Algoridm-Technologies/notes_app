import 'package:flutter/material.dart';

import '../../model/employee_and_note_model.dart';

class SearchProvider extends ChangeNotifier {
  final List<Notes> _positions = [];
  bool _isChecking = false;
  int _selected = -1;

  List<Notes> get positions => _positions;
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

  addToList(Notes position) {
    _positions.add(position);
   
    notifyListeners();
  }

  removeToList(Notes position) {
    _positions.remove(position);
 
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class SetStateProvider extends ChangeNotifier {
  bool _isReplying = false;

  bool get isReplying => _isReplying;

  changeState(bool isReplying) {
    _isReplying = isReplying;
    notifyListeners();
  }
}

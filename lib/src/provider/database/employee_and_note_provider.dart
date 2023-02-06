import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/employee_and_note_api.dart';
import 'package:note/src/model/employee_and_note_model.dart';

class EmployeeAndNoteProvider extends ChangeNotifier {
  List<Notes?> _list = [];
  List<Employees?> _em = [];
  List<Notes?> get list => _list;
  List<Employees?> get em => _em;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  getFacility() async {
    _isLoading = true;
    var facility = await EmployeeAndNoteApi.currentEmployeeAndFacility();

    if (facility == "Failed" || facility == "Error") {
      _list = [];
      _em = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = EmployeeAndNoteModel.fromJson(jsonDecode(facility));

      _list = model.notes!;
      _em = model.employees!;
      _isLoading = false;

      notifyListeners();
    }
  }
}
//email officialrrye3@gmail.com
//password a3S9LZfiTQeR
//email officialrrye4@gmail.com
//password RSSJQYNNdFCY
//officialrrye21@gmail.com  CFMkJdzrDi0s
//officialrrye22@gmail.com  iDWslpq2VjVN
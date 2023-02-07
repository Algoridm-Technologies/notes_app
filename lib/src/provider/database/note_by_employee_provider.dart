import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/note_by_employee_api.dart';

import '../../model/employee_and_note_model.dart';
import '../../model/note_by_employee_model.dart';

class NoteByEmployeeProvider extends ChangeNotifier {
  List<Notes?> _myList = [];
  List<Notes?> get myList => _myList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  getFacility({required String employeeId}) async {
    _isLoading = true;
    var facility =
        await NoteByEmployeeApi.noteByEmployee(employeeId: employeeId);
    print(facility);

    if (facility == "Failed" || facility == "Error") {
      _myList = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = NoteByEmployeeModel.fromJson(jsonDecode(facility));

      _myList = model.notes!;
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
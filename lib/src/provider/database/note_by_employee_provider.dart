import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/note_by_employee_api.dart';
import 'package:note/src/model/employee_note_model.dart';

class NoteByEmployeeProvider extends ChangeNotifier {
  List<MyNotes?> _myList = [];
  List<TeamMatesNotes?> _teamList = [];
  List<MyNotes?> get myList => _myList;
  List<TeamMatesNotes?> get em => _teamList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  getFacility({required String employeeId}) async {
    _isLoading = true;
    var facility =
        await NoteByEmployeeApi.noteByEmployee(employeeId: employeeId);
    print(facility);

    if (facility == "Failed" || facility == "Error") {
      _myList = [];
      _teamList = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = EmployeeNoteModel.fromJson(jsonDecode(facility));

      _myList = model.myNotes!;
      _teamList = model.teamMatesNotes!;
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
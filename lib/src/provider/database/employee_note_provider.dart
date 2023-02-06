import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/current_employee_and_facility_api.dart';
import 'package:note/src/model/employee_note_model.dart';

class EmployeeNoteProvider extends ChangeNotifier {
  List<MyNotes?> _myList = [];
  List<TeamMatesNotes?> _teamList = [];
  List<MyNotes?> get myList => _myList;
  List<TeamMatesNotes?> get em => _teamList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  getFacility() async {
    _isLoading = true;
    var facility =
        await CurrentEmployeeAndFacilityApi.currentEmployeeAndFacility();

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
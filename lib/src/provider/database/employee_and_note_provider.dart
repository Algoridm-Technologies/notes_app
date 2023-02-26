import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/employee_and_note_api.dart';
import 'package:note/src/api/list_all_employee_api.dart';
import 'package:note/src/api/list_all_note_api.dart';
import 'package:note/src/model/employee_and_note_model.dart';

import '../../api/note_by_facility_api.dart';

class EmployeeAndNoteProvider extends ChangeNotifier {
  List<Notes?> _list = [];
  List<Employees?> _em = [];
  List<Notes?> get list => _list;
  List<Employees?> get em => _em;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  getFacility() async {
    _isLoading = true;
    notifyListeners();
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

  getEmployee() async {
    _isLoading = true;
    notifyListeners();
    var facility = await ListAllEmployeeApi.listEmployees();

    if (facility == "Failed" || facility == "Error") {
      _em = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = jsonDecode(facility)['data'];
      _em = model
          .map<Employees>(
              (data) => Employees.fromJson(data as Map<String, Object?>))
          .toList();
      _isLoading = false;

      notifyListeners();
    }
  }

  getNote() async {
    _isLoading = true;
    notifyListeners();
    var facility = await ListAllNotesApi.listNotes();

    if (facility == "Failed" || facility == "Error") {
      _list = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = jsonDecode(utf8.decode(facility))['data'];
      log(model.toString());
      _list = model
          .map<Notes>((data) => Notes.fromJson(data as Map<String, Object?>))
          .toList();
      _isLoading = false;
      notifyListeners();
    }
  }

  getNoteBy({required String facilityId}) async {
    _isLoading = true;
    notifyListeners();
    var facility = await NotesByFacilityApi.listNotes(facilityId: facilityId);

    if (facility == "Failed" || facility == "Error") {
      _list = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = jsonDecode(utf8.decode(facility))['notes'];
      print(model.toString());
      _list = model
          .map<Notes>((data) => Notes.fromJson(data as Map<String, Object?>))
          .toList();
      _isLoading = false;
      notifyListeners();
    }
  }

    getEmployeeBy({required String facilityId}) async {
    _isLoading = true;
    notifyListeners();
    var facility = await NotesByFacilityApi.listNotes(facilityId: facilityId);

     if (facility == "Failed" || facility == "Error") {
      _em = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = jsonDecode(utf8.decode(facility))['employees'];
      _em = model
          .map<Employees>(
              (data) => Employees.fromJson(data as Map<String, Object?>))
          .toList();
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
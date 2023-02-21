import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/model/facility_model.dart';

import '../../api/list_facility_api.dart';

class FacilityProvider extends ChangeNotifier {
  List<Facilities?> _list = [];
  List<Facilities?> get list => _list;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  getFacility() async {
    _isLoading = true;
    notifyListeners();
    var facility = await ListFacilityApi.listFacility();
print(facility);
    if (facility == "Failed" && facility == "Error") {
      _list = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = FacilityModel.fromJson(jsonDecode(facility));
      _list = model.facilities!;
      _isLoading = false;

      notifyListeners();
    }
  }
}
//email officialrrye3@gmail.com
//password a3S9LZfiTQeR
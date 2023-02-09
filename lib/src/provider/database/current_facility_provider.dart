import 'package:flutter/foundation.dart';
import 'package:note/src/model/current_facility_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentFacilityProvider extends ChangeNotifier {
  CurrentFacilityModel? _model;
  CurrentFacilityModel? get model => _model!;
  bool get isLoggedIn => _model != null;

  setAccess({
    required String facilityName,
    required String facilityId,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('facilityName', facilityName);
    prefs.setString('facilityId', facilityId);
    notifyListeners();
  }

  getAccess() async {
    var prefs = await SharedPreferences.getInstance();
    var facilityName = prefs.getString('facilityName');
    var facilityId = prefs.getString('facilityId');
    prefs.getString('facilityId');
    _model = CurrentFacilityModel(
      facilityName: facilityName,
      facilityId: facilityId,
    );
    notifyListeners();
  }
}

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUserApi {
  static Future<dynamic> addUser({
    required String fullName,
    required String email,
    required String facilityId,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/add-employee/");
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'full_name': fullName,
        'email': email,
        'facility_id': facilityId,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

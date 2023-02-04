import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectFacilityApi {
  static Future<dynamic> selectFacility({
    required String id,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/facilities/");
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'id': id,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

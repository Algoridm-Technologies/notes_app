import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListFacilityApi {
  static Future<String> listFacility() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/facilities/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });
      print(response.body);
      if (response.statusCode.toString()[0] == "2") {
        return response.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return 'Error';
    }
  }
}

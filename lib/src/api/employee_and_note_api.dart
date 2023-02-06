import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeAndNoteApi {
  static Future<String> currentEmployeeAndFacility() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var session = prefs.getString("session");
      dynamic url = Uri.parse("$baseUrl/notes/employer-dashboard/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "cookie": "$session",
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

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListAllEmployeeApi {
  static Future<dynamic> listEmployees() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/all-employees/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });
      // print(response.body);
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

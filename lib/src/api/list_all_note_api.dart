import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListAllNotesApi {
  static Future<dynamic> listEmployees() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/all-notes/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

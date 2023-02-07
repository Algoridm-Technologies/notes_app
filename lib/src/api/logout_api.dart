import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutApi {
  static Future<String> logout() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/auth/logout/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Error';
    }
  }
}

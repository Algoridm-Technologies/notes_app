import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListNotificationApi {
  static Future<dynamic> listNotification() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/profiles/notifications/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

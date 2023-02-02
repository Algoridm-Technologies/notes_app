import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshApi {
  static Future<String> refresh() async {
    var prefs = await SharedPreferences.getInstance();
    var refresh = prefs.getString("refresh");

    try {
      dynamic url = Uri.parse("$baseUrl/auth/refresh/");
      var response = await http.post(url, body: {
        'refresh': refresh,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

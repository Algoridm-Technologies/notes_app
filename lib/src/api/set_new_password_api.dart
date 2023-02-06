import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetNewPasswordApi {
  static Future<String> setNewPassword({
    required String password,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var session = prefs.getString('session')!;
    try {
      dynamic url = Uri.parse("$baseUrl/auth/set-new-password/");
      var response = await http.post(url, headers: {
        "cookie": session,
      }, body: {
        'password': password,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

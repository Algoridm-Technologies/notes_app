import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class LoginUserApi {
  static Future<dynamic> loginUserApi({
    required String email,
    required String password,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/login/");
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      String? rawCookie = response.headers["set-cookie"];
      if (rawCookie != null) {
        int index = rawCookie.indexOf(';');
        String v = (index == -1) ? rawCookie : rawCookie.substring(0, index);
        // prefs.setString("session", v);
      }

      return response.body;
    } catch (e) {
     
      return 'Error';
    }
  }
}

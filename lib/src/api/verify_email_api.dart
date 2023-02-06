import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class VerifyEmailApi {
  static Future<dynamic> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/verify-email/");
      var response = await http.post(url, body: {
        'email': email,
        'otp': otp,
      });
      print(response.body);
      print(response.headers["set-cookie"]);
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

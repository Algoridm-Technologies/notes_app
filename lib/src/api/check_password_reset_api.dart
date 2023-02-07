import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPasswordResetOtpApi {
  static Future<String> checkPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      dynamic url = Uri.parse("$baseUrl/auth/check-password-reset-otp/");
      var response = await http.post(url, body: {
        'email': email,
        'otp': otp,
      });
  
      String? rawCookie = response.headers["set-cookie"];
      if (rawCookie != null) {
        int index = rawCookie.indexOf(';');
        String v = (index == -1) ? rawCookie : rawCookie.substring(0, index);
        prefs.setString("session", v);
      }

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

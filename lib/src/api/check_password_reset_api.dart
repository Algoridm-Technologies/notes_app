import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class CheckPasswordResetOtpApi {
  static Future<String> checkPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/check-password-reset-otp/");
      var response = await http.post(url, body: {
        'email': email,
        'otp': otp,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class RequestPasswordResetOtpApi {
  static Future<String> requestPasswordResetOtp({
    required String email,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/request-password-reset-otp/");
      var response = await http.post(url, body: {
        'email': email,
      });
   

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

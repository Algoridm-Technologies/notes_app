import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class ResendEmailVerificationApi {
  static Future<String> resendEmailVerification({
    required String email,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/resend-email-verification-otp/");
      var response = await http.post(url, body: {
        'email': email,
      });
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

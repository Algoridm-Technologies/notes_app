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
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

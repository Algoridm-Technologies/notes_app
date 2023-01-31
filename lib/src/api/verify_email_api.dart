import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class VerifyEmailApi {
  Future<String> verifyEmailApi({
    required String email,
    required String otp,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/verify-email/");
      var response = await http.post(url, body: {
        'email': email,
        'otp': otp,
      });

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Error';
    }
  }
}

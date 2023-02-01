import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class SetNewPasswordApi {
  static Future<String> setNewPassword({
    required String password,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/set-new-password/");
      var response = await http.post(url, body: {
        'password': password,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

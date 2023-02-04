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

      return response.body;
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}

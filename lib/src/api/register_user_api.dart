import 'package:http/http.dart' as http;

class RegisterUserApi {
  static Future<dynamic> registerUser({
    required String fullName,
    required String email,
    required bool isEmployer,
    required String password,
  }) async {
    try {
      dynamic url =
          Uri.parse("https://noteapp-api.herokuapp.com/api/v1/auth/register/");
      var response = await http.post(url, body: {
        'full_name': fullName,
        'email': email,
        'password': password,
        'is_employer': isEmployer.toString(),
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

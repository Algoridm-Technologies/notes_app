import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class LoginUserApi {
  Future<String> loginUserApi({
    required String email,
    required String password,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/login/");
      var response = await http.post(url, body: {
     
        'email': email,
        'password': password,
     
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

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class LogoutApi {
  Future<String> logout() async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/set-new-password/");
      var response = await http.get(url);

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

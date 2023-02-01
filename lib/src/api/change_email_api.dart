import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class ChangeEmailApi {
  Future<String> changeEmail({
    required String email,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/profiles/change-email/");
      var response = await http.post(url, body: {
        'email': email,
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

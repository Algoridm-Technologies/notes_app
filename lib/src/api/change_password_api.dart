import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class ChangePasswordApi {
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/profiles/change-password/");
      var response = await http.post(url, body: {
        'current_password': currentPassword,
        'new_password': newPassword,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

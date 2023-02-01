import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class UpdateProfileApi {
  Future<String> updateProfile({
    required String fullName,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/profiles/detail/");
      var response = await http.post(url, body: {
        'full_name': fullName,
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

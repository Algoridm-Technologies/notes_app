import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class RefreshApi {
  Future<String> refreshApi() async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/refresh/");
      var response = await http.post(url, body: {
        'refresh':
            '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzUxOTc1NjIsImRhdGEiOiIwMURSNDgxRVBFIn0.ijGp1KVflwa9mXxYwixCC90BE4o67D5m-_o_lZrXSIU''',
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

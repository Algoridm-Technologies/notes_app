import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteNoteApi {
  static Future<dynamic> deleteNote({
    required String id,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/facilities/");
      var response = await http.delete(url, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'id': id,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

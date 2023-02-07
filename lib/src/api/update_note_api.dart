import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateNoteApi {
  static Future<String> updateNote({
    required String title,
    required String text,
    required String? noteId,
  }) async {
    await RefreshToken.refreshToken();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/employee-dashboard/$noteId/");

      var request = http.MultipartRequest("PATCH", url);

      request.fields['title'] = title;
      request.fields['text'] = text;
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });

      var response = await request.send();

      var data = await http.Response.fromStream(response);
     

      return data.body;
    } catch (e) {
     
      return 'Error';
    }
  }
}

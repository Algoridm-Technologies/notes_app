import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSingleNoteEmployerDetailApi {
  static Future<dynamic> getSingleNoteDetail({
    required String noteId,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var session = prefs.getString("session");
      dynamic url = Uri.parse("$baseUrl/notes/employer-dashboard/$noteId/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Cookie": "$session",
      });
      if (response.statusCode.toString()[0] == "2") {
        return response.bodyBytes;
      } else {
        return "Failed";
      }
    } catch (e) {
      return 'Error';
    }
  }
}

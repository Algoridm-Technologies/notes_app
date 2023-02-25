import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSingleNoteEmployeeDetailApi {
  static Future<dynamic> getSingleNoteDetail({
    required String noteId,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/employee-dashboard/$noteId/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
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

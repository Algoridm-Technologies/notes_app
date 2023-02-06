import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSingleNoteEmployerDetailApi {
  static Future<String> getSingleNoteDetail({
    required String noteId,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/employer-dashboard/$noteId/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Cookie": "sessionid=ddsntj7fzkqv39uys8wy30rfapmdh0h0",
      });
      print(response.body);
      if (response.statusCode.toString()[0] == "2") {
        return response.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return 'Error';
    }
  }
}

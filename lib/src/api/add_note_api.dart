import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteApi {
  static Future<dynamic> addNote({
    required String title,
    required String body,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/employee-dashboard/");
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'title': title,
        'text': body,
      });
      log(response.body);

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

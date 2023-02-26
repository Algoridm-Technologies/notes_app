import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListAllNotesApi {
  static Future<dynamic> listNotes() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      dynamic url = Uri.parse("$baseUrl/notes/all-notes/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });
      try {
        log(jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(e);
      }

      return response.bodyBytes;
    } catch (e) {
      return 'Error';
    }
  }
}

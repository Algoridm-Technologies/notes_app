import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteNoteApi {
  static Future<dynamic> deleteNote({
    required List<String> id,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/employer-dashboard/");
      var response = await http.delete(url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"note_ids": id}));

      return response.body;
    } catch (e) {
    
      return 'Error';
    }
  }
}

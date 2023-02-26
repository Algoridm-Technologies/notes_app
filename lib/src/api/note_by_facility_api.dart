import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesByFacilityApi {
  static Future<dynamic> listNotes({required String facilityId}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var session = prefs.getString("session");
      dynamic url = Uri.parse("$baseUrl/notes/notes-by-facility/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
         "cookie": "$session",
      });
      print(response.body);
      // try {
      //   log(jsonDecode(utf8.decode(response.bodyBytes)));
      // } catch (e) {
      //   print(e);
      // }

      return response.bodyBytes;
    } catch (e) {
      return 'Error';
    }
  }
}

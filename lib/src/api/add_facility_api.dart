import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFacilityApi {
  static Future<String> addFacility({
    required String name,
    required String location,
    required File d,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dynamic url = Uri.parse("$baseUrl/notes/add-facility/");
      var stream = http.ByteStream(d.openRead());
      stream.cast();
      var request = http.MultipartRequest("POST", url);

      request.fields['title'] = name;
      request.fields['location'] = location;
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });
      
      request.files.add(await http.MultipartFile.fromPath("image", d.path));
    
      var response = await request.send();

      var data = await http.Response.fromStream(response);
      print(data.body);
      return data.body;
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}

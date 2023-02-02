import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class AddFacilityApi {
  static Future<String> addFacility({
    required String name,
    required String location,
    required File file,
  }) async {
    try {
      dynamic url = Uri.parse("$baseUrl/notes/add-facility/");
      var response = await http.post(url, body: {
        'name': name,
        'location': location,
        'image': file.path,
      });

      print(response.body);
      return response.body;
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileApi {
  static Future<String> updateProfile({
    required String fullName,
    File? d,
  }) async {
    await RefreshToken.refreshToken();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/profiles/detail/");
      var stream = http.ByteStream(d!.openRead());
      stream.cast();
      var request = http.MultipartRequest("PATCH", url);

      request.fields['full_name'] = fullName;
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });
      if (d!=null) {
          request.files.add(await http.MultipartFile.fromPath("avatar", d.path));
      }
    
      var response = await request.send();

      var data = await http.Response.fromStream(response);
  

      return "re.body";
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}

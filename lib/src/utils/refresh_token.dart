import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/refresh.dart';

class RefreshToken {
  static Future refreshToken() async {
    var refresh = await RefreshApi.refresh();
    print(refresh);
if (jsonDecode(refresh)['error']!=null) {
  
} else {
   var prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh", jsonDecode(refresh)['refresh']);
    prefs.setString("token", jsonDecode(refresh)['access']);
}
   
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/refresh.dart';

class RefreshToken {
  static refreshToken() async {
    var refresh = await RefreshApi.refresh();

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh", jsonDecode(refresh)['refresh']);
    prefs.setString("token", jsonDecode(refresh)['access']);
  }
}

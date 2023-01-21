import 'package:shared_preferences/shared_preferences.dart';

class UserAuthProvider {
  Future<String> checkUser() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }
}

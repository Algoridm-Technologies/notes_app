import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class ReadNotificationApi {
  Future<String> readNotification() async {
    try {
      dynamic url = Uri.parse("$baseUrl/profiles/notifications/sdfghjhgfds/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Error';
    }
  }
}

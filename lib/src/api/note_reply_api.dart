import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteReplyApi {
  static Future<dynamic> noteReply({
    required String noteId,
    required String replyId,
    required String text,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      dynamic url = Uri.parse("$baseUrl/notes/note-reply/");
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'note_id': noteId,
        'reply_id': replyId,
        'text': text,
      });

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}

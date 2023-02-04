import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:note/src/model/access_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AccessProvider extends ChangeNotifier {
  AccessModel? _model;
  AccessModel? get model => _model!;
  bool get isLoggedIn => _model != null;

  setAccess() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? "";

    Map<String, dynamic> data = Jwt.parseJwt(token);
    //  var id =
    // Provider.of<AccessProvider>(context, listen: false).model!.userId;
    print(data['user_id']);
    // ListNoteApi.listNote(noteId: data['user_id']);

    _model = AccessModel.fromMap(data);
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/get_single_note_employer_api.dart';
import 'package:note/src/model/note_detail_model.dart';
import 'package:note/src/utils/refresh_token.dart';

class NoteDetailEmployerProvider extends ChangeNotifier {
  List<Replies> _list = [];
  List<Replies> get list => _list;
  NoteDetailModel? _model;
  NoteDetailModel? get model => _model;
  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool get isEmpty => model == null;

  setisProcessing(bool value) {
    value = _isProcessing;
    notifyListeners();
  }

  getFacility(String noteId) async {
    _isLoading = true;

    notifyListeners();
    await RefreshToken.refreshToken();

    var facility = await GetSingleNoteEmployerDetailApi.getSingleNoteDetail(
        noteId: noteId);
    // print(facility);

    if (facility == "Failed" || facility == "Error") {
      _list = [];
      _model = null;
      _isLoading = false;
      notifyListeners();
    } else {
      var myModel = NoteDetailModel.fromJson(jsonDecode(utf8.decode(facility)));
      _model = myModel;
      _list = myModel.replies!;

      _isLoading = false;
      notifyListeners();
    }
  }
}
//email officialrrye3@gmail.com
//password a3S9LZfiTQeR
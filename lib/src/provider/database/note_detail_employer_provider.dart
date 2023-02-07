import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/get_single_note_employer_api.dart';
import 'package:note/src/model/note_detail_model.dart';

class NoteDetailEmployerProvider extends ChangeNotifier {
  List<Replies> _list = [];
  List<Replies> get list => _list;
  NoteDetailModel? _model;
  NoteDetailModel? get model => _model;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isEmpty => model == null;
  getFacility(String noteId) async {
    _isLoading = true;
    var facility = await GetSingleNoteEmployerDetailApi.getSingleNoteDetail(
        noteId: noteId);

    if (facility == "Failed" || facility == "Error") {
      _list = [];
      _model = null;
      _isLoading = false;
      notifyListeners();
    } else {
      var myModel = NoteDetailModel.fromJson(jsonDecode(facility));
      _model = myModel;
      _list = myModel.replies!;

      _isLoading = false;

      notifyListeners();
    }
  }
}
//email officialrrye3@gmail.com
//password a3S9LZfiTQeR
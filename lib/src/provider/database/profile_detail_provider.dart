import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/profile_detail_api.dart';
import 'package:note/src/model/profile_detail_model.dart';
import 'package:note/src/utils/refresh_token.dart';

class ProfileDetailProvider extends ChangeNotifier {
  ProfileDetailModel? _model;
  ProfileDetailModel? get model => _model!;
  bool get isLoggedIn => _model != null;

  getDetails() async {
    await RefreshToken.refreshToken();
    var data = await ProfileDetailApi.getProfileDetail();
    log(data.toString());

    _model = ProfileDetailModel.fromJson(data);
    notifyListeners();
  }
}

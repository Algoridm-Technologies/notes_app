import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note/src/api/list_notification_api.dart';
import 'package:note/src/model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel?> _list = [];
  List<NotificationModel?> get list => _list;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  getFacility() async {
    _isLoading = true;
    notifyListeners();
    var facility = await ListNotificationApi.listNotification();

    if (facility == "Failed" && facility == "Error") {
      _list = [];
      _isLoading = false;
      notifyListeners();
    } else {
      var model = jsonDecode(facility).length;
      _list.clear();
      for (var i = 0; i < model; i++) {
        _list.add(NotificationModel.fromMap(jsonDecode(facility)[i]));
      }
      _isLoading = false;

      notifyListeners();
    }
  }
}
//email officialrrye3@gmail.com
//password a3S9LZfiTQeR
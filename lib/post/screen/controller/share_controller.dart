import 'package:flutter/material.dart';

import '../model/user_modal.dart';
import '../service/user_api.dart';

class ShareController extends ChangeNotifier {
  UserProfile? userProfile;
  void add(UserProfile person) {
    userProfile = person;
    notifyListeners();
  }

  Future<void> getUser(String uid) async {
    print('running share controller');
    print(uid);
    FireBaseApi api = FireBaseApi();
    final user = await api.checkUser(uid);
    if (user != null) {
      add(user);
    }
  }
}

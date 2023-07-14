import 'package:shared_preferences/shared_preferences.dart';

class SharedUtil {
  Future<void> setUserLoggedIn(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('uid', uid);
  }

  Future<String?> checkLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? uid = pref.getString('uid');
    return uid;
  }
}

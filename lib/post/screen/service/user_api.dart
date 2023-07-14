import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post_modal.dart';
import '../model/user_modal.dart';

class FireBaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future createUser(
      String name, String email, String url, String authUid) async {
    try {
      var docuser = await firestore.collection('user').doc(authUid).get();
      UserProfile userprofile = UserProfile(
        name: name,
        url: url,
        email: email,
        uid: docuser.reference.id,
      );
      await docuser.reference.set(userprofile.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile?> checkUser(String authUid) async {
    try {
      var doc = await firestore.collection('user').doc(authUid).get();
      if (doc.exists) {
        print(doc.data());
        return UserProfile.frommap(doc.data()!);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }
}

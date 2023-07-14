import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/post/screen/service/post_api.dart';
import 'package:taskapp/post/screen/service/user_api.dart';
import '../controller/share_controller.dart';
import '../screen/screen/home.dart';
import '../screen/screen/post.dart';
import '../utils/shared_login.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FireBaseApi api = FireBaseApi();
  FireBasePost fireBasePost = FireBasePost();

  Future<void> signWithGoogle(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sharePro = Provider.of<ShareController>(context, listen: false);

    //TODO: Create a loading state when the user is signing in is done

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        if (kDebugMode) {
          print(googleSignInAccount.email);
        }

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final UserCredential usercredential =
            await _auth.signInWithCredential(authCredential);

        if (usercredential.user != null) {
          SharedUtil().setUserLoggedIn(usercredential.user!.uid);
          await checkUser(googleSignInAccount, usercredential.user!.uid);
          await sharePro.getUser(usercredential.user!.uid);
        }
        navigator.push(MaterialPageRoute(builder: (context) => const Post()));

        //TODO: Create a user model and upload it to firebase firestore when a new user sign in
        //TODO: Cache that UID into a provider and shared pref
      } else {
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        // TODO: handel login exceptions with a class
      }
      rethrow;
    }
  }

  signout(context) async {
    final navigator = Navigator.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    //Clear all providers
    await _auth.signOut();
    await googleSignIn.signOut();
    await pref.clear();

    navigator.pushReplacement(MaterialPageRoute(builder: (_) => Homes()));
  }

  Future<void> checkUser(
    GoogleSignInAccount accountDetail,
    String authUid,
  ) async {
    final user = await api.checkUser(accountDetail.email);
    if (user == null) {
      await api.createUser(
        accountDetail.displayName ?? 'User',
        accountDetail.email,
        accountDetail.photoUrl ?? "",
        authUid,
      );
    }
  }
}

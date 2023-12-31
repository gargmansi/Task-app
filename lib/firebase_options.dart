// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBPK2T_ZY2e1gFjRRQVg-iqhmZJoYFIEOU',
    appId: '1:693774876814:web:a10f31cd798a94c71189df',
    messagingSenderId: '693774876814',
    projectId: 'taskapp-cba85',
    authDomain: 'taskapp-cba85.firebaseapp.com',
    storageBucket: 'taskapp-cba85.appspot.com',
    measurementId: 'G-S5RWZE7R88',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOOeRU3vhd4vd8BLJzsG8quHpB5Urlk6Q',
    appId: '1:693774876814:android:257c8eed3daf2edf1189df',
    messagingSenderId: '693774876814',
    projectId: 'taskapp-cba85',
    storageBucket: 'taskapp-cba85.appspot.com',
  );
}

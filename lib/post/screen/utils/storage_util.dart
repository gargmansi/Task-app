import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageUtil {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> uploadImage(File image) async {
    final docRef = await firebaseStorage
        .ref(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(image);
    final imageUrl = await docRef.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> removeImage(String url) async {
    try {
      await firebaseStorage.refFromURL(url).delete();
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';

class PicImagecontroller extends ChangeNotifier {
  String? imageUrl;

  void addImage(String newImageUrl) {
    imageUrl = newImageUrl;
    notifyListeners();
  }

  void removeImage() {
    imageUrl = null;
    notifyListeners();
  }
}

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtil {
  Future<File?> pickImageCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final picked = await imagePicker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      return File(picked.path);
    }
    return null;
  }

  Future<File?> pickImageGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final picked = await imagePicker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      return File(picked.path);
    }
    return null;
  }
}

import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickImage(ImageSource sourse) async {
    try {
      final XFile? imageX = await ImagePicker().pickImage(source: sourse);
      final File? image = imageX != null ? File(imageX.path) : null;
      return image;
    } on PlatformException catch (e) {
      dev.log('Failed to pick image: $e');
      return null;
    }
  }
}

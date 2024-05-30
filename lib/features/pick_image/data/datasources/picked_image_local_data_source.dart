// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/features/pick_image/data/models/picked_image_model.dart';

abstract class PickedImageLocalDataSource {
  /// Should open the gallery and pick an image from there
  ///
  /// Should throw an Erreur if something goes wrong
  Future<PickedImageModel?> pickImageFromGallery();
}

class PickedImageLocalDataSourceImpl implements PickedImageLocalDataSource {
  PickedImageLocalDataSourceImpl({required this.imagePicker});
  final ImagePicker imagePicker;

  @override
  Future<PickedImageModel?> pickImageFromGallery() async {
    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {
        return null;
      }
      return PickedImageModel(image: File(pickedImage.path));
    } on PlatformException catch (code) {
      throw ServerException(errorMessage: code.message!);
    }
  }
}

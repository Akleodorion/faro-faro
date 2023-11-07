import 'dart:io';

import 'package:faro_clean_tdd/features/pick_image/domain/entities/picked_image.dart';

class PickedImageModel extends PickedImage {
  const PickedImageModel({required super.image});

  factory PickedImageModel.fromJson(Map<String, dynamic> json) {
    return PickedImageModel(image: File(json["name"]));
  }

  Map<String, dynamic> toJson() {
    return {'name': image.path};
  }
}

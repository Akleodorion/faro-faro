// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/features/pick_image/data/models/picked_image_model.dart';
import 'package:faro_faro/features/pick_image/domain/entities/picked_image.dart';

void main() async {
  final tPickedImageModel = PickedImageModel(image: File('flyers.jpg'));

  test(
    "should be a subclass of Address",
    () async {
      //assert

      expect(tPickedImageModel, isA<PickedImage>());
    },
  );

  group('FromJson', () {
    test(
      "should return a valid  of AddressModel",
      () async {
        //act

        //assert
      },
    );
  });

  group('toJson', () {
    test(
      "should return a valid Json",
      () async {
        //act
        final result = tPickedImageModel.toJson();
        final tExpectedMap = {'name': 'flyers.jpg'};
        //assert
        expect(result, equals(tExpectedMap));
      },
    );
  });
}

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_faro/features/pick_image/data/models/picked_image_model.dart';
import 'picked_image_local_data_source_test.mocks.dart';

@GenerateMocks([ImagePicker])
void main() {
  late MockImagePicker mockImagePicker;
  late PickedImageLocalDataSourceImpl pickedImageLocalDataSourceImpl;

  setUp(() {
    mockImagePicker = MockImagePicker();
    pickedImageLocalDataSourceImpl =
        PickedImageLocalDataSourceImpl(imagePicker: mockImagePicker);
  });

  group(
    "pickImageFromGallery",
    () {
      final tXfile = XFile('flyers.jpg');
      final tFile = File(tXfile.path);
      final tPickedImageModel = PickedImageModel(image: tFile);
      test(
        "should return a valid PickedImageModel",
        () async {
          //arrange
          when(mockImagePicker.pickImage(source: ImageSource.gallery))
              .thenAnswer((_) async => tXfile);
          //act
          final result =
              await pickedImageLocalDataSourceImpl.pickImageFromGallery();
          //assert
          expect(result!.image.path, tPickedImageModel.image.path);
        },
      );

      test(
        "should return null if no image was picked",
        () async {
          //arrange
          when(mockImagePicker.pickImage(source: ImageSource.gallery))
              .thenAnswer((_) async => null);
          //act
          final result =
              await pickedImageLocalDataSourceImpl.pickImageFromGallery();
          //assert
          expect(result, null);
        },
      );

      test(
        "should return a ServerException if an PlatformException is sent",
        () async {
          //arrange
          when(mockImagePicker.pickImage(source: ImageSource.gallery))
              .thenThrow(PlatformException(code: 'any', message: 'oops'));
          //act et assert
          expect(
            () => pickedImageLocalDataSourceImpl.pickImageFromGallery(),
            throwsA(isA<ServerException>()),
          );
        },
      );
    },
  );
}

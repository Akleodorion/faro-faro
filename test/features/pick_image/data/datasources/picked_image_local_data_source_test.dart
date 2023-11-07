import 'dart:io';

import 'package:faro_clean_tdd/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_clean_tdd/features/pick_image/data/models/picked_image_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
      final tPickedImageModel = PickedImageModel(image: File(tXfile.path));
      // test(
      //   "should return the PickedImageModel",
      //   () async {
      //     //arrange
      //     when(mockImagePicker.pickImage(source: ImageSource.gallery))
      //         .thenAnswer((_) async => tXfile);
      //     //act
      //     final result =
      //         await pickedImageLocalDataSourceImpl.pickImageFromGallery();
      //     //assert
      //     expect(result, tPickedImageModel);
      //   },
      // );
    },
  );
}

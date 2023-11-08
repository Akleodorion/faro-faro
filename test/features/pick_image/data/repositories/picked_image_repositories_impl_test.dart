import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_clean_tdd/features/pick_image/data/models/picked_image_model.dart';
import 'package:faro_clean_tdd/features/pick_image/data/repositories/picked_image_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'picked_image_repositories_impl_test.mocks.dart';

@GenerateMocks([PickedImageLocalDataSource])
void main() {
  late MockPickedImageLocalDataSource mockPickedImageLocalDataSource;
  late PickedImageRepositoryImpl pickedImageRepositoryImpl;

  setUp(() {
    mockPickedImageLocalDataSource = MockPickedImageLocalDataSource();
    pickedImageRepositoryImpl =
        PickedImageRepositoryImpl(repository: mockPickedImageLocalDataSource);
  });

  group('pickImageFromGalery', () {
    final tPickedImageModel = PickedImageModel(image: File('flyers.jpg'));
    test(
      "should return the File is the call has been successfull",
      () async {
        //arrange
        when(mockPickedImageLocalDataSource.pickImageFromGallery())
            .thenAnswer((_) async => tPickedImageModel);
        //act
        final result = await pickedImageRepositoryImpl.pickImageFromGalery();
        //assert
        expect(result, Right(tPickedImageModel));
      },
    );

    test(
      "should return null when no image is selected",
      () async {
        //arrange
        when(mockPickedImageLocalDataSource.pickImageFromGallery())
            .thenAnswer((_) async => null);
        //act
        final result = await pickedImageRepositoryImpl.pickImageFromGalery();
        //assert
        expect(result, const Right(null));
      },
    );

    test(
      "should return a ServerFailure if the call is unsuccessfull",
      () async {
        //arrange
        when(mockPickedImageLocalDataSource.pickImageFromGallery())
            .thenThrow(ServerException(errorMessage: 'oops'));
        //act
        final result = await pickedImageRepositoryImpl.pickImageFromGalery();
        //assert
        expect(result, const Left(ServerFailure(errorMessage: 'oops')));
      },
    );
  });
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/repositories/picked_image_repository.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pick_image_from_gallery_test.mocks.dart';

@GenerateMocks([PickedImageRepository])
void main() {
  late MockPickedImageRepository mockPickedImageRepository;
  late PickImageFromGalery pickImageFromGalery;

  setUp(() {
    mockPickedImageRepository = MockPickedImageRepository();
    pickImageFromGalery =
        PickImageFromGalery(repository: mockPickedImageRepository);
  });

  test(
    "should return Right(File) when successfull",
    () async {
      final File image = File('flyers.jpg');
      //arrange
      when(mockPickedImageRepository.pickImageFromGalery())
          .thenAnswer((_) async => Right(image));
      //act
      final result = await pickImageFromGalery.call();
      //assert
      expect(result, Right(image));
    },
  );

  test(
    "should return left(ServerFailure) when unsuccssfull",
    () async {
      //arrange
      when(mockPickedImageRepository.pickImageFromGalery()).thenAnswer(
          (_) async => const Left(ServerFailure(errorMessage: 'oops')));
      //act
      final result = await pickImageFromGalery.call();
      //assert
      expect(result, const Left(ServerFailure(errorMessage: 'oops')));
    },
  );
}

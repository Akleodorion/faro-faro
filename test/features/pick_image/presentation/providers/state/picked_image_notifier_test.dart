import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/entities/picked_image.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_notifier.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'picked_image_notifier_test.mocks.dart';

@GenerateMocks([PickImageFromGalery])
void main() {
  late MockPickImageFromGalery mockPickImageFromGalery;
  late PickedImageNotifier pickedImageNotifier;
  setUp(() {
    mockPickImageFromGalery = MockPickImageFromGalery();
    pickedImageNotifier = PickedImageNotifier(
        pickImageFromGaleryUsecase: mockPickImageFromGalery);
  });

  test(
    "initialState should be Loading",
    () async {
      //assert
      expect(pickedImageNotifier.initialState, Initial());
    },
  );

  group('PickImageFromGallery', () {
    final tPickedImage = PickedImage(image: File('flyers.jpg'));
    test(
      "should call the Usecase ",
      () async {
        //arrange
        when(mockPickImageFromGalery.call())
            .thenAnswer((_) async => Right(tPickedImage));
        //act
        await pickedImageNotifier.pickImageFromGalery();
        //assert
        verify(mockPickImageFromGalery.call()).called(1);
      },
    );

    test(
      "should emit [loading, loaded] if the request is successful",
      () async {
        //arrange
        when(mockPickImageFromGalery.call())
            .thenAnswer((_) async => Right(tPickedImage));

        //assert later
        final expectedState = [Loading(), Loaded(pickedImage: tPickedImage)];
        expectLater(pickedImageNotifier.stream, emitsInOrder(expectedState));
        //act

        await pickedImageNotifier.pickImageFromGalery();
      },
    );

    test(
      "should emit [loading, error] if the request is unsuccessful",
      () async {
        //arrange
        when(mockPickImageFromGalery()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure(errorMessage: 'oops')));
        //assert later
        final expectedState = [Loading(), Error(message: 'oops')];
        expectLater(pickedImageNotifier.stream, emitsInOrder(expectedState));
        //assert
        await pickedImageNotifier.pickImageFromGalery();
      },
    );
  });
}

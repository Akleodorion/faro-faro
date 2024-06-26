// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/events/data/models/event_model.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';
import 'package:faro_faro/features/events/domain/usecases/update_an_event.dart';
import 'update_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late UpdateAnEventUsecase sut;

  setUp(() {
    mockEventRepository = MockEventRepository();
    sut = UpdateAnEventUsecase(repository: mockEventRepository);
  });

  group(
    "execute",
    () {
      final tFile = File("flyers.jpg");
      final tEvent = EventModel(
          name: "name",
          id: 1,
          description: "description",
          date: DateTime.now(),
          startTime: const TimeOfDay(hour: 18, minute: 00),
          endTime: const TimeOfDay(hour: 18, minute: 00),
          address: const Address(
              latitude: 4.7,
              longitude: -3.9,
              geocodeUrl: "geocodeUrl",
              country: "Côte d'Ivoire",
              countryCode: "CI",
              locality: "Abidjan",
              plusCode: "9359+HXR",
              road: "Route d'Abatta",
              sublocality: "Cocody"),
          category: Category.concert,
          imageUrl: tFile.path,
          userId: 1,
          modelEco: ModelEco.gratuit,
          members: const [],
          tickets: const [],
          activated: false,
          closed: false,
          maxStandardTicket: 20,
          standardTicketDescription: "standardTicketDescription");
      test(
        "should return a valid Event if the call is a success",
        () async {
          //arrange
          when(mockEventRepository.updateAnEvent(
                  event: anyNamed('event'), image: anyNamed('image')))
              .thenAnswer((realInvocation) async => Right(tEvent));
          //act
          final result = await sut.execute(event: tEvent, image: tFile);
          //assert
          expect(result, Right(tEvent));
        },
      );

      test(
        "should return a ServerFailure is the call is not a success",
        () async {
          //arrange
          when(mockEventRepository.updateAnEvent(
                  event: anyNamed('event'), image: anyNamed('image')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(event: tEvent, image: tFile);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: "oops")));
        },
      );
    },
  );
}

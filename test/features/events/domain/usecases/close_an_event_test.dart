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
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';
import 'package:faro_faro/features/events/domain/usecases/close_an_event.dart';
import 'close_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late CloseAnEvent sut;

  setUp(() {
    mockEventRepository = MockEventRepository();
    sut = CloseAnEvent(repository: mockEventRepository);
  });

  group(
    "execute",
    () {
      const tEventId = 1;
      final tEvent1 = Event(
        name: 'Event 1',
        id: tEventId,
        description: 'short description',
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
        imageUrl: 'imageUrl',
        userId: 1,
        modelEco: ModelEco.gratuit,
        members: const [],
        tickets: const [],
        activated: false,
        closed: false,
        standardTicketPrice: 5000,
        maxStandardTicket: 50,
        standardTicketDescription: "Standard ticket simple description",
        goldTicketPrice: 10000,
        maxGoldTicket: 25,
        goldTicketDescription: "vip ticket simple description",
        platinumTicketPrice: 15000,
        maxPlatinumTicket: 10,
        platinumTicketDescription: "vvip ticket simple description",
      );
      test(
        "should return a valid Event when the call is a success",
        () async {
          //arrange
          when(mockEventRepository.closeAnEvent(eventId: anyNamed('eventId')))
              .thenAnswer((realInvocation) async => Right(tEvent1));
          //act
          final result = await sut.execute(eventId: tEventId);
          //assert
          expect(result, Right(tEvent1));
          verify(mockEventRepository.closeAnEvent(eventId: tEventId)).called(1);
        },
      );

      test(
        "should return a ServerFailure when the call is a not success",
        () async {
          //arrange
          when(mockEventRepository.closeAnEvent(eventId: anyNamed('eventId')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(eventId: tEventId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
          verify(mockEventRepository.closeAnEvent(eventId: tEventId)).called(1);
        },
      );
    },
  );
}

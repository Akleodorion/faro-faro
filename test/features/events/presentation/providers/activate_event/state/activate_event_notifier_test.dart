import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'activate_event_notifier_test.mocks.dart';

@GenerateMocks([ActivateAnEvent])
void main() {
  late MockActivateAnEvent mockActivateAnEvent;
  late ActivateEventNotifier sut;

  setUp(() {
    mockActivateAnEvent = MockActivateAnEvent();
    sut = ActivateEventNotifier(activateAnEventUsecase: mockActivateAnEvent);
  });

  test(
    "should get the initial state",
    () async {
      //act
      final result = sut.initialState;
      //assert
      expect(result, Initial());
    },
  );

  group(
    "activateAnEvent",
    () {
      final tEvent = EventModel(
        name: 'Event 1',
        eventId: 1,
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
        "should emit [loading, loaded]",
        () async {
          //arrange
          when(mockActivateAnEvent.execute(eventId: anyNamed('eventId')))
              .thenAnswer((realInvocation) async => Right(tEvent));
          //act
          final expectedResult = [Loading(), Loaded(event: tEvent)];
          expectLater(sut.stream, emitsInOrder(expectedResult));
          //assert
          await sut.activateAnEvent(eventId: 1);
        },
      );

      test(
        "should emit [loading, Error]",
        () async {
          //arrange
          when(mockActivateAnEvent.execute(eventId: anyNamed('eventId')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final expectedResult = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedResult));
          //assert
          await sut.activateAnEvent(eventId: 1);
        },
      );
    },
  );
}

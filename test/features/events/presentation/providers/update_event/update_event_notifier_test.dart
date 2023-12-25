import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/update_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/update_event/state/update_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/update_event/state/update_event_state.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'update_event_notifier_test.mocks.dart';

@GenerateMocks([UpdateAnEventUsecase])
void main() {
  late MockUpdateAnEventUsecase mockUpdateAnEventUsecase;
  late UpdateEventNotifier updateEventNotifier;

  setUpAll(() {
    mockUpdateAnEventUsecase = MockUpdateAnEventUsecase();
    updateEventNotifier =
        UpdateEventNotifier(updateAnEventUsecase: mockUpdateAnEventUsecase);
  });

  // Usecases tests
  test(
    "initialState should be Loading",
    () async {
      //assert
      expect(updateEventNotifier.initialState, Initial(infoMap: const {}));
    },
  );
  const tSuccessMessage = "Réussi";
  const tMember1 = MemberModel(id: 1, userId: 1, eventId: 1, username: "test");
  const tMember2 = MemberModel(id: 2, userId: 2, eventId: 1, username: "test2");
  const tTicket1 = TicketModel(
      id: 1,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 1,
      qrCodeUrl: "qrCodeUrl",
      verified: false);
  const tTicket2 = TicketModel(
      id: 2,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 2,
      qrCodeUrl: "qrCodeUrl",
      verified: false);
  const tTickets = [tTicket1, tTicket2];
  const tMembers = [tMember1, tMember2];
  group('postAnEvent', () {
    final tEvent = EventModel(
      name: 'Event 1',
      id: 1,
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
      members: tMembers,
      tickets: tTickets,
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

    final tImage = File('flyers.jpg');

    test(
      "should emit [Loading, Loaded] if the request is successfull ",
      () async {
        //arrange
        when(mockUpdateAnEventUsecase.execute(event: tEvent, image: tImage))
            .thenAnswer((_) async => Right(tEvent));
        //assert
        final expectedState = [
          Loading(),
          Loaded(event: tEvent, message: tSuccessMessage)
        ];
        expectLater(updateEventNotifier.stream, emitsInOrder(expectedState));
        // act
        await updateEventNotifier.updateAnEvent(event: tEvent, image: tImage);
      },
    );

    test(
      "should emit [Error] if the request is unsuccessful",
      () async {
        //arrange
        when(mockUpdateAnEventUsecase.execute(event: tEvent, image: tImage))
            .thenAnswer((realInvocation) async => const Left(
                ServerFailure(errorMessage: "an error has occured")));
        //act
        final expectedState = [
          Loading(),
          Error(infoMap: const {}, message: "an error has occured")
        ];
        expectLater(updateEventNotifier.stream, emitsInOrder(expectedState));
        //assert
        await updateEventNotifier.updateAnEvent(event: tEvent, image: tImage);
      },
    );
  });
}

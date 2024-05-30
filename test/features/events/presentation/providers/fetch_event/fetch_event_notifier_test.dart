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
import 'package:faro_faro/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/state/fetch_event_notifier.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/state/fetch_event_state.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'fetch_event_notifier_test.mocks.dart';

@GenerateMocks([FetchAllEvents])
void main() {
  late MockFetchAllEvents mockFetchAllEvents;
  late FetchEventNotifier fetchEventNotifier;

  setUpAll(() {
    mockFetchAllEvents = MockFetchAllEvents();
    fetchEventNotifier = FetchEventNotifier(
      fetchAllEventsUsecase: mockFetchAllEvents,
    );
  });
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
      qrCodeUrl: "qrCodeUrl",
      userId: 2,
      verified: false);
  const tTickets = [tTicket1, tTicket2];
  const tMembers = [tMember1, tMember2];

  final tEvent1 = Event(
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

  final tEvent2 = Event(
    name: 'Event 2',
    id: 2,
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
    category: Category.culture,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.payant,
    members: tMembers,
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

  final tEvents = [tEvent1, tEvent2];

  // Usecases tests
  test(
    "initialState should be Loading",
    () async {
      //assert
      expect(fetchEventNotifier.initialState, Loading());
    },
  );

  group(
    "fetchAllEvents",
    () {
      test(
        "should emit [Loaded] if the request is successful",
        () async {
          // arrange

          when(mockFetchAllEvents.execute())
              .thenAnswer((realInvocation) async => Right(tEvents));
          //assert
          final expectedState = [
            Loaded(
                indexEvent: tEvents,
                allEvents: tEvents,
                message: tSuccessMessage)
          ];
          expectLater(fetchEventNotifier.stream, emitsInOrder(expectedState));
          //act

          await fetchEventNotifier.fetchAllEvents();
        },
      );

      test(
        "should emit [Error] if the request is successful",
        () async {
          //arrange
          when(mockFetchAllEvents.execute()).thenAnswer(
              (realInvocation) async => const Left(
                  ServerFailure(errorMessage: "an error has occured")));
          //act
          final expectedState = [
            Error(indexEvent: const [], message: "an error has occured")
          ];
          expectLater(fetchEventNotifier.stream, emitsInOrder(expectedState));
          //assert
          await fetchEventNotifier.fetchAllEvents();
        },
      );
    },
  );

  group(
    "searchEvent",
    () {
      final tEvents10 = [
        tEvent1,
        tEvent2,
        tEvent1,
        tEvent2,
        tEvent1,
        tEvent2,
        tEvent1,
        tEvent2,
        tEvent1,
        tEvent2,
      ];
      final teventState = Loaded(
        indexEvent: tEvents10,
        allEvents: tEvents10,
        message: tSuccessMessage,
      );
      test(
        "should return a eventState with the index Event filtered",
        () async {
          //act
          final result =
              fetchEventNotifier.searchEvent('Event 1 ', teventState);
          //assert

          final tExpected = Loaded(
            indexEvent: [
              tEvent1,
              tEvent1,
              tEvent1,
              tEvent1,
              tEvent1,
            ],
            allEvents: tEvents10,
            message: tSuccessMessage,
          );
          expect(result, tExpected);
        },
      );
    },
  );
}

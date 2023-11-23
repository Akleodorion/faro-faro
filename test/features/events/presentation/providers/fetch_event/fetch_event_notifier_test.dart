import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/state/fetch_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/state/fetch_event_state.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

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

  const tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const tMember2 = Member(id: 2, userId: 2, eventId: 1);
  const tMembers = [tMember1, tMember2];

  final tEvent1 = Event(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime(2023, 12, 15),
    address: const Address(
        latitude: 10.5264,
        longitude: 20.4585,
        addressName: "addressName",
        geocodeUrl: "geocodeUrl"),
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.gratuit,
    members: tMembers,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vipTicketDescription: "vip ticket simple description",
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
    vvipTicketDescription: "vvip ticket simple description",
  );

  final tEvent2 = Event(
    name: 'Event 2',
    eventId: 2,
    description: 'short description',
    date: DateTime.now(),
    address: const Address(
        latitude: 10.5264,
        longitude: 20.4585,
        addressName: "addressName",
        geocodeUrl: "geocodeUrl"),
    category: Category.culture,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.payant,
    members: tMembers,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vipTicketDescription: "vip ticket simple description",
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
    vvipTicketDescription: "vvip ticket simple description",
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
            )
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
      final teventState = Loaded(indexEvent: tEvents10, allEvents: tEvents10);
      test(
        "should return a eventState with the index Event filtered",
        () async {
          //act
          final result =
              fetchEventNotifier.searchEvent('Event 1 ', teventState);
          //assert

          final tExpected = Loaded(indexEvent: [
            tEvent1,
            tEvent1,
            tEvent1,
            tEvent1,
            tEvent1,
          ], allEvents: tEvents10);
          expect(result, tExpected);
        },
      );
    },
  );
}

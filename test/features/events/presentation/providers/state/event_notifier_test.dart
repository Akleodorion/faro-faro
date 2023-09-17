import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'event_notifier_test.mocks.dart';

@GenerateMocks([FetchAllEvents])
void main() {
  late MockFetchAllEvents mockFetchAllEvents;
  late EventNotifier eventNotifier;

  setUpAll(() {
    mockFetchAllEvents = MockFetchAllEvents();
    eventNotifier = EventNotifier(fetchAllEventsUsecase: mockFetchAllEvents);
  });

  final tEvent1 = Event(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime.now(),
    location: 'Lille',
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.gratuit,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
  );

  final tEvent2 = Event(
    name: 'Event 2',
    eventId: 2,
    description: 'short description',
    date: DateTime.tryParse('2023-09-05T10:46:37.232Z')!,
    location: 'Arras',
    category: Category.culture,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.payant,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
  );

  final tEvents = [tEvent1, tEvent2];

  test(
    "initialState should be Loading",
    () async {
      //assert
      expect(eventNotifier.initialState, Loading());
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
                randomEvents: tEvents,
                upcomingEvents: tEvents)
          ];
          expectLater(eventNotifier.stream, emitsInOrder(expectedState));
          //act

          await eventNotifier.fetchAllEvents();
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
          expectLater(eventNotifier.stream, emitsInOrder(expectedState));
          //assert
          await eventNotifier.fetchAllEvents();
        },
      );
    },
  );

  group(
    "getRandomEvent",
    () {
      final tEvents20 = [
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
        tEvent1,
        tEvent2,
      ];
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
      test(
        "should return a suffled list of 10 events if the list of events is more than 20",
        () async {
          //act
          final result = eventNotifier.getRandomEvent(tEvents20);
          //assert
          expect(result, isNot(tEvents));
          expect(result.length, equals(10));
        },
      );

      test(
        "should return a suffled list of 5 events if the list of events is more than 10 and less than 20",
        () async {
          //act
          final result = eventNotifier.getRandomEvent(tEvents10);
          //assert
          expect(result, isNot(tEvents));
          expect(result.length, equals(5));
        },
      );

      test(
        "should return an empty list of events if the list of events is less than 5",
        () async {
          //act
          final result = eventNotifier.getRandomEvent(tEvents);
          //assert
          expect(result, []);
        },
      );
    },
  );

  group(
    "getUpcomingEvent",
    () {
      final tEvents20 = [
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
      test(
        "should return an ordered list of 10 events if the list of events is more than 20",
        () async {
          //act
          final result = eventNotifier.getUpcomingEvent(tEvents20);
          final expected = [
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
          ];
          //assert
          expect(result, expected);
          expect(result.length, equals(10));
        },
      );

      test(
        "should return an ordered list of 5 events if the list of events is more than 10 and less than 20",
        () async {
          //act
          final result = eventNotifier.getUpcomingEvent(tEvents10);
          final expected = [
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
            tEvent2,
          ];
          //assert
          expect(result, expected);
          expect(result.length, equals(5));
        },
      );

      test(
        "should return an empty list of events if the list of events is less than 5",
        () async {
          //act
          final result = eventNotifier.getUpcomingEvent(tEvents);
          //assert
          expect(result, []);
        },
      );
    },
  );
}

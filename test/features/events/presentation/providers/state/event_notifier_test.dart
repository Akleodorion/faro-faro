import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_random_events.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_upcoming_events.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'event_notifier_test.mocks.dart';

@GenerateMocks([FetchRandomEvents, FetchUpcomingEvents, FetchAllEvents])
void main() {
  late MockFetchRandomEvents mockFetchRandomEvents;
  late MockFetchUpcomingEvents mockFetchUpcomingEvents;
  late MockFetchAllEvents mockFetchAllEvents;
  late EventNotifier eventNotifier;

  setUpAll(() {
    mockFetchRandomEvents = MockFetchRandomEvents();
    mockFetchUpcomingEvents = MockFetchUpcomingEvents();
    mockFetchAllEvents = MockFetchAllEvents();
    eventNotifier = EventNotifier(
        fetchAllEventsUsecase: mockFetchAllEvents,
        fetchRandomEventsUsecase: mockFetchRandomEvents,
        fetchUpcomingEventsUsecase: mockFetchUpcomingEvents);
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
      modelEco: ModelEco.gratuit);

  final tEvent2 = Event(
      name: 'Event 2',
      eventId: 2,
      description: 'short description',
      date: DateTime.now(),
      location: 'Arras',
      category: Category.culture,
      imageUrl: 'imageUrl',
      userId: 1,
      modelEco: ModelEco.payant);

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
          final expectedState = [Loaded(indexEvent: tEvents)];
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
}

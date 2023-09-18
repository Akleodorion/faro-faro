import 'dart:async';

import '../../../domain/usecases/fetch_all_events.dart';
import 'event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/event.dart';

class EventNotifier extends StateNotifier<EventState> {
  // usecases
  final FetchAllEvents fetchAllEventsUsecase;

  EventState get initialState => Loading();

  // initialisation
  EventNotifier({
    required this.fetchAllEventsUsecase,
  }) : super(Loading());

  // Usecases

  Future<EventState?> fetchAllEvents() async {
    final response = await fetchAllEventsUsecase.execute();
    response!.fold((failure) {
      state = Error(indexEvent: const [], message: "an error has occured");
    }, (events) {
      state = Loaded(
          indexEvent: events,
          randomEvents: getRandomEvent(events),
          upcomingEvents: getUpcomingEvent(events));
    });
    return state;
  }

  List<Event> getRandomEvent(List<Event> events) {
    final List<Event> randomEvents = events;
    randomEvents.shuffle();

    if (randomEvents.length >= 20) {
      return randomEvents.sublist(0, 10);
    } else if (randomEvents.length >= 10) {
      return randomEvents.sublist(0, 5);
    } else {
      return [];
    }
  }

  List<Event> getUpcomingEvent(List<Event> events) {
    final List<Event> upcomingEvents = events;
    upcomingEvents.sort((event1, event2) => event1.date.compareTo(event2.date));

    if (upcomingEvents.length >= 20) {
      return upcomingEvents.sublist(0, 10);
    } else if (upcomingEvents.length >= 10) {
      return upcomingEvents.sublist(0, 5);
    } else {
      return [];
    }
  }
}

import 'dart:io';

import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';

import '../../../data/models/event_model.dart';
import '../../../domain/usecases/fetch_all_events.dart';
import 'event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/event.dart';

class EventNotifier extends StateNotifier<EventState> {
  final FetchAllEvents fetchAllEventsUsecase;
  final PostAnEvent postAnEventUsecase;

  EventState get initialState => Loading();

  // initialisation
  EventNotifier(
      {required this.fetchAllEventsUsecase, required this.postAnEventUsecase})
      : super(Loading());

  // Usecases

  Future<EventState?> fetchAllEvents() async {
    final response = await fetchAllEventsUsecase.execute();
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(indexEvent: const [], message: failure.errorMessage);
      }
    }, (events) {
      state = Loaded(
          indexEvent: events,
          allEvents: events,
          randomEvents: getRandomEvent(events),
          upcomingEvents: getUpcomingEvent(events));
    });
    return state;
  }

  Future<EventState?> postAnEvent(
      {required EventModel event, required File image}) async {
    List<Event> indexEvent = [];
    List<Event> allEvents = [];
    List<Event> randomEvents = [];
    List<Event> upcomingEvents = [];
    EventState eventState = state;

    if (eventState is Loaded) {
      indexEvent = List.from(eventState.indexEvent);
      allEvents = List.from(eventState.allEvents);
      randomEvents = List.from(eventState.randomEvents);
      upcomingEvents = List.from(eventState.upcomingEvents);
    }

    state = Loading();
    final response =
        await postAnEventUsecase.execute(event: event, image: image);
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(indexEvent: indexEvent, message: failure.errorMessage);
      }
    }, (event) {
      allEvents.add(event);
      state = Loaded(
          indexEvent: indexEvent,
          randomEvents: randomEvents,
          upcomingEvents: upcomingEvents,
          allEvents: allEvents);
    });
    return state;
  }

  // Méthodes

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

  EventState? searchEvent(String researchInput, EventState eventState) {
    if (eventState is Loaded) {
      final filteredEvent = eventState.allEvents
          .where((event) =>
              (event.name.toUpperCase().contains(researchInput.toUpperCase()) ||
                  event.description
                      .toUpperCase()
                      .contains(researchInput.toUpperCase())))
          .toList();
      state = Loaded(
          indexEvent: filteredEvent,
          randomEvents: eventState.randomEvents,
          upcomingEvents: eventState.upcomingEvents,
          allEvents: eventState.allEvents);
    }
    return state;
  }
}

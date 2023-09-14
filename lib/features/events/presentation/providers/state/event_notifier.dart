import 'dart:async';

import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/fetch_random_events.dart';
import '../../../domain/usecases/fetch_upcoming_events.dart';

class EventNotifier extends StateNotifier<EventState> {
  // usecases
  final FetchAllEvents fetchAllEventsUsecase;
  final FetchRandomEvents fetchRandomEventsUsecase;
  final FetchUpcomingEvents fetchUpcomingEventsUsecase;
  EventState get initialState => Loading();

  // initialisation
  EventNotifier(
      {required this.fetchAllEventsUsecase,
      required this.fetchRandomEventsUsecase,
      required this.fetchUpcomingEventsUsecase})
      : super(Loading());

  // Usecases

  Future<EventState?> fetchAllEvents() async {
    final response = await fetchAllEventsUsecase.execute();
    response!.fold((failure) {
      state = Error(indexEvent: const [], message: "an error has occured");
    }, (events) {
      state = Loaded(indexEvent: events);
    });
    return state;
  }

  Future<EventState?> fetchRandomEvents() async {
    return null;
  }

  Future<EventState?> fetchUpcomingEvents() async {
    return null;
  }
}

import 'package:faro_clean_tdd/core/errors/failures.dart';

import '../../../../domain/usecases/fetch_all_events.dart';
import 'fetch_event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchEventNotifier extends StateNotifier<FetchEventState> {
  final FetchAllEvents fetchAllEventsUsecase;

  FetchEventState get initialState => Loading();

  // initialisation
  FetchEventNotifier({
    required this.fetchAllEventsUsecase,
  }) : super(Loading());

  // Usecases

  Future<FetchEventState?> fetchAllEvents() async {
    final response = await fetchAllEventsUsecase.execute();
    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(indexEvent: const [], message: failure.errorMessage);
      }
    }, (events) {
      state = Loaded(
          indexEvent: events,
          allEvents: events,
          message: "Les évènements ont étés récupérés avec succès!");
    });
    return state;
  }

  // Méthodes

  FetchEventState searchEvent(
      String researchInput, FetchEventState eventState) {
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
          allEvents: eventState.allEvents,
          message: "Les évènements ont étés récupérés avec succès!");
    }
    return state;
  }
}

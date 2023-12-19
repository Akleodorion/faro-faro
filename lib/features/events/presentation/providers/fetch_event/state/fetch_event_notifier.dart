import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

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

  void addMemberToEvent({
    required MemberModel member,
    required Event event,
    required FetchEventState fetchEventState,
  }) {
    if (fetchEventState is Loaded) {
      final udpatedAllEvents = fetchEventState.allEvents.map((e) {
        if (e == event) {
          return e.copyWith(members: [...e.members, member]);
        }
        return e;
      }).toList();

      state = Loaded(
          indexEvent: fetchEventState.indexEvent,
          allEvents: udpatedAllEvents,
          message: fetchEventState.message);
    }
  }

  void removeMemberfromEvent({
    required Member member,
    required Event event,
    required FetchEventState fetchEventState,
  }) {
    if (fetchEventState is Loaded) {
      final udpatedAllEvents = fetchEventState.allEvents.map((e) {
        if (e == event) {
          return e.copyWith(
              members: e.members.where((m) => m != member).toList());
        }
        return e;
      }).toList();
      state = Loaded(
          indexEvent: fetchEventState.indexEvent,
          allEvents: udpatedAllEvents,
          message: fetchEventState.message);
    }
  }

  void setEventActivatedToTrue(
      {required Event event, required FetchEventState fetchEventState}) {
    if (fetchEventState is Loaded) {
      final updatedEventList =
          List<Event>.from(fetchEventState.allEvents).map((e) {
        if (e.id == event.id) {
          return e.copyWith(activated: true);
        }
        return e;
      }).toList();

      state = Loaded(
          indexEvent: fetchEventState.indexEvent,
          allEvents: updatedEventList,
          message: fetchEventState.message);
    }
  }

  void setEventClosedToTrue(
      {required Event event, required FetchEventState fetchEventState}) {
    if (fetchEventState is Loaded) {
      final updatedEventList =
          List<Event>.from(fetchEventState.allEvents).map((e) {
        if (e.id == event.id) {
          return e.copyWith(closed: true);
        }
        return e;
      }).toList();

      state = Loaded(
          indexEvent: fetchEventState.indexEvent,
          allEvents: updatedEventList,
          message: fetchEventState.message);
    }
  }
}

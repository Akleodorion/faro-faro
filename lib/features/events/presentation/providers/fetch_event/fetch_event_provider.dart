// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/fetch_all_events.dart';
import 'state/fetch_event_notifier.dart';
import 'state/fetch_event_state.dart';

final fetchEventProvider =
    StateNotifierProvider<FetchEventNotifier, FetchEventState>((ref) {
  final FetchAllEvents fetchAllEvents = sl<FetchAllEvents>();

  return FetchEventNotifier(
    fetchAllEventsUsecase: fetchAllEvents,
  );
});

final allEventProvider = Provider<List<Event>>((ref) {
  final eventState = ref.watch(fetchEventProvider);
  return eventState is Loaded ? eventState.allEvents : [];
});

final indexEventProvider = Provider<List<Event>>((ref) {
  final eventState = ref.watch(fetchEventProvider);
  return eventState is Loaded ? eventState.indexEvent : [];
});

final randomEventsProvider = Provider<List<Event>>((ref) {
  final List<Event> randomEvents = ref.watch(allEventProvider);
  randomEvents.shuffle();

  if (randomEvents.length >= 20) {
    return randomEvents.sublist(0, 10);
  } else if (randomEvents.length >= 10) {
    return randomEvents.sublist(0, 5);
  } else {
    return [];
  }
});

final upcomingEventProvider = Provider<List<Event>>((ref) {
  final events = ref.watch(allEventProvider);
  final List<Event> upcomingEvents = events;
  upcomingEvents.sort((event1, event2) => event1.date.compareTo(event2.date));

  if (upcomingEvents.length >= 20) {
    return upcomingEvents.sublist(0, 10);
  } else if (upcomingEvents.length >= 10) {
    return upcomingEvents.sublist(0, 5);
  } else {
    return [];
  }
});

final myEventProvider = Provider<List<Event>>((ref) {
  final userId = ref.watch(userInfoProvider)["user_id"];
  final events = ref.watch(allEventProvider);

  final myEvents = events.where((event) => event.userId == userId).toList();
  return myEvents;
});

import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';

import '../../domain/usecases/fetch_all_events.dart';
import 'state/event_notifier.dart';
import 'state/event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  final FetchAllEvents fetchAllEvents = sl<FetchAllEvents>();
  final PostAnEvent postAnEvent = sl<PostAnEvent>();

  return EventNotifier(
    fetchAllEventsUsecase: fetchAllEvents,
    postAnEventUsecase: postAnEvent,
  );
});

final eventsProvider = Provider<List<Event>>((ref) {
  final eventState = ref.watch(eventProvider);
  return eventState is Loaded ? eventState.indexEvent : [];
});

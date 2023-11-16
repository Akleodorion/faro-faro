import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';

import '../../../domain/usecases/fetch_all_events.dart';
import 'state/fetch_event_notifier.dart';
import 'state/fetch_event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection_container.dart';

final fetchEventProvider =
    StateNotifierProvider<FetchEventNotifier, FetchEventState>((ref) {
  final FetchAllEvents fetchAllEvents = sl<FetchAllEvents>();

  return FetchEventNotifier(
    fetchAllEventsUsecase: fetchAllEvents,
  );
});

final eventsProvider = Provider<List<Event>>((ref) {
  final eventState = ref.watch(fetchEventProvider);
  return eventState is Loaded ? eventState.indexEvent : [];
});

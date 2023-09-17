import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  final FetchAllEvents fetchAllEvents = sl<FetchAllEvents>();

  return EventNotifier(
    fetchAllEventsUsecase: fetchAllEvents,
  );
});

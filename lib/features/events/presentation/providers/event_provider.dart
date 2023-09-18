import '../../domain/usecases/fetch_all_events.dart';
import 'state/event_notifier.dart';
import 'state/event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  final FetchAllEvents fetchAllEvents = sl<FetchAllEvents>();

  return EventNotifier(
    fetchAllEventsUsecase: fetchAllEvents,
  );
});

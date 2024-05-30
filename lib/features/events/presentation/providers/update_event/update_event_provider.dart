// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../../../injection_container.dart';
import '../../../domain/usecases/update_an_event.dart';
import '../update_event/state/update_event_state.dart';
import 'state/update_event_notifier.dart';

final updateEventProvider =
    StateNotifierProvider<UpdateEventNotifier, UpdateEventState>((ref) {
  final UpdateAnEventUsecase updateAnEvent = sl();
  return UpdateEventNotifier(
    updateAnEventUsecase: updateAnEvent,
  );
});

final updateEventMapProvider = Provider<Map<String, dynamic>>((ref) {
  final state = ref.watch(updateEventProvider);
  if (state is Initial) {
    return state.infoMap;
  }
  return {};
});

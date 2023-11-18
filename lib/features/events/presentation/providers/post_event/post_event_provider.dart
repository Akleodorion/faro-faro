import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection_container.dart';

final postEventProvider =
    StateNotifierProvider<PostEventNotifier, PostEventState>((ref) {
  final PostAnEvent postAnEvent = sl<PostAnEvent>();
  return PostEventNotifier(
    postAnEventUsecase: postAnEvent,
  );
});

final postEventMapProvider = Provider<Map<String, dynamic>>((ref) {
  final state = ref.watch(postEventProvider);
  if (state is Initial) {
    return state.infoMap;
  }
  return {};
});

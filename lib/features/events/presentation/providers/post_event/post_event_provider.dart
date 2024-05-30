// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/state/post_event_notifier.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/state/post_event_state.dart';
import '../../../../../injection_container.dart';

final postEventProvider =
    StateNotifierProvider<PostEventNotifier, PostEventState>((ref) {
  final PostAnEvent postAnEvent = sl<PostAnEvent>();
  return PostEventNotifier(
    postAnEventUsecase: postAnEvent,
  );
});

final postEventModelEcoStatusProvider = Provider<bool>((ref) {
  final state = ref.watch(postEventProvider);

  if (state is Initial) {
    return state.isFree;
  }
  return false;
});

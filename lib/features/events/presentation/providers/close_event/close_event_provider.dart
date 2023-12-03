import 'package:faro_clean_tdd/features/events/domain/usecases/close_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/state/close_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/state/close_event_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final closeEventStateProvider =
    StateNotifierProvider<CloseEventNotifier, CloseEventState>((ref) {
  final CloseAnEvent closeAnEvent = sl();

  return CloseEventNotifier(closeAnEventUsecase: closeAnEvent);
});

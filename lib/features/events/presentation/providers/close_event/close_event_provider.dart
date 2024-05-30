// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/usecases/close_an_event.dart';
import 'package:faro_faro/features/events/presentation/providers/close_event/state/close_event_notifier.dart';
import 'package:faro_faro/features/events/presentation/providers/close_event/state/close_event_state.dart';
import 'package:faro_faro/injection_container.dart';

final closeEventStateProvider =
    StateNotifierProvider<CloseEventNotifier, CloseEventState>((ref) {
  final CloseAnEvent closeAnEvent = sl();

  return CloseEventNotifier(closeAnEventUsecase: closeAnEvent);
});

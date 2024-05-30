// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_faro/features/events/presentation/providers/activate_event/state/activate_event_notifier.dart';
import 'package:faro_faro/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:faro_faro/injection_container.dart';

final activateEventStateProvider =
    StateNotifierProvider<ActivateEventNotifier, ActivateEventState>((ref) {
  final ActivateAnEvent activateAnEvent = sl();

  return ActivateEventNotifier(activateAnEventUsecase: activateAnEvent);
});

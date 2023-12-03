import 'package:faro_clean_tdd/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activateEventStateProvider =
    StateNotifierProvider<ActivateEventNotifier, ActivateEventState>((ref) {
  final ActivateAnEvent activateAnEvent = sl();

  return ActivateEventNotifier(activateAnEventUsecase: activateAnEvent);
});

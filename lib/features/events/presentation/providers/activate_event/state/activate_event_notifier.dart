import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivateEventNotifier extends StateNotifier<ActivateEventState> {
  final ActivateAnEvent activateAnEventUsecase;

  ActivateEventState get initialState => Initial();

  // initialisation
  ActivateEventNotifier({
    required this.activateAnEventUsecase,
  }) : super(Initial());

  // Usecases

  Future<ActivateEventState?> activateAnEvent({required int eventId}) async {
    state = Loading();
    final response = await activateAnEventUsecase.execute(eventId: eventId);
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (event) {
      state = Loaded(event: event);
    });
    return state;
  }
}

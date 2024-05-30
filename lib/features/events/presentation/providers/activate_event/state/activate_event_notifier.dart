// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_faro/features/events/presentation/providers/activate_event/state/activate_event_state.dart';

class ActivateEventNotifier extends StateNotifier<ActivateEventState> {
  final ActivateAnEvent activateAnEventUsecase;

  ActivateEventState get initialState => Initial();

  // initialisation
  ActivateEventNotifier({
    required this.activateAnEventUsecase,
  }) : super(Initial());

  // Usecases

  Future<ActivateEventState> activateAnEvent({required int eventId}) async {
    state = Loading();
    final response = await activateAnEventUsecase.execute(eventId: eventId);
    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (event) {
      state = Loaded(
          event: event, message: "L'évènement a été activé avec succès!");
    });
    return state;
  }
}

import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/close_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/state/close_event_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CloseEventNotifier extends StateNotifier<CloseEventState> {
  final CloseAnEvent closeAnEventUsecase;

  CloseEventState get initialState => Initial();

  // initialisation
  CloseEventNotifier({
    required this.closeAnEventUsecase,
  }) : super(Initial());

  // Usecases

  Future<CloseEventState?> closeAnEvent({required int eventId}) async {
    state = Loading();
    final response = await closeAnEventUsecase.execute(eventId: eventId);
    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (event) {
      state = Loaded(
          event: event, message: "L'évènement a été fermée avec succès!");
    });
    return state;
  }
}

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/events/domain/usecases/close_an_event.dart';
import 'package:faro_faro/features/events/presentation/providers/close_event/state/close_event_state.dart';

class CloseEventNotifier extends StateNotifier<CloseEventState> {
  final CloseAnEvent closeAnEventUsecase;

  CloseEventState get initialState => Initial();

  // initialisation
  CloseEventNotifier({
    required this.closeAnEventUsecase,
  }) : super(Initial());

  // Usecases

  Future<CloseEventState> closeAnEvent({required int eventId}) async {
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

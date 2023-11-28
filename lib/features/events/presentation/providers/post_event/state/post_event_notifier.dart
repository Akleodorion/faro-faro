import 'dart:io';

import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';

import '../../../../data/models/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostEventNotifier extends StateNotifier<PostEventState> {
  final PostAnEvent postAnEventUsecase;

  PostEventState get initialState => Initial(isFree: false);

  // initialisation
  PostEventNotifier({
    required this.postAnEventUsecase,
  }) : super(Initial(isFree: false));

  // Usecases
  Future<PostEventState?> postAnEvent(
      {required EventModel event, required File image}) async {
    state = Loading();
    final response =
        await postAnEventUsecase.execute(event: event, image: image);
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (event) {
      state = Loaded(event: event);
    });
    return state;
  }

  void updateModelEco(ModelEco modelEco) {
    if (state is Initial) {
      state = Initial(isFree: modelEco == ModelEco.gratuit ? true : false);
    }
  }

  void reset(Map<String, dynamic>? map) {
    state = Initial(isFree: false);
  }
}

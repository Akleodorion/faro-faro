import 'dart:io';

import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/update_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/update_event/state/update_event_state.dart';

import '../../../../data/models/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
final INIT = {
  'address': '',
  'category': Category.concert,
  'date': DateTime.now(),
  'description': '',
  'imageFile': File(''),
  'latitude': 0.0,
  'longitude': 0.0,
  'maxStandardTicket': 0,
  'maxVipTicket': 0,
  'maxVvipTicket': 0,
  'modelEco': ModelEco.gratuit,
  'name': '',
  'standardTicketDescription': '',
  'standardTicketPrice': 0,
  'vipTicketDescription': '',
  'vipTicketPrice': 0,
  'vvipTicketDescription': '',
  'vvipTicketPrice': 0,
};

class UpdateEventNotifier extends StateNotifier<UpdateEventState> {
  final UpdateAnEventUsecase updateAnEventUsecase;

  UpdateEventState get initialState => Initial(infoMap: {
        'address': '',
        'category': Category.concert,
        'date': DateTime.now(),
        'description': '',
        'imageFile': File(''),
        'latitude': 0.0,
        'longitude': 0.0,
        'maxStandardTicket': 0,
        'maxVipTicket': 0,
        'maxVvipTicket': 0,
        'modelEco': ModelEco.gratuit,
        'name': '',
        'standardTicketDescription': '',
        'standardTicketPrice': 0,
        'vipTicketDescription': '',
        'vipTicketPrice': 0,
        'vvipTicketDescription': '',
        'vvipTicketPrice': 0,
      });

  // initialisation
  UpdateEventNotifier({
    required this.updateAnEventUsecase,
  }) : super(Initial(infoMap: {
          'address': '',
          'category': Category.concert,
          'date': DateTime.now(),
          'description': '',
          'imageFile': File(''),
          'latitude': 0.0,
          'longitude': 0.0,
          'maxStandardTicket': 0,
          'maxVipTicket': 0,
          'maxVvipTicket': 0,
          'modelEco': ModelEco.gratuit,
          'name': '',
          'standardTicketDescription': '',
          'standardTicketPrice': 0,
          'vipTicketDescription': '',
          'vipTicketPrice': 0,
          'vvipTicketDescription': '',
          'vvipTicketPrice': 0,
        }));

  // Usecases
  Future<UpdateEventState?> updateAnEvent(
      {required EventModel event, required File image}) async {
    Map<String, dynamic> map = {};
    final updateEventState = state;
    if (updateEventState is Initial) {
      map = Map.from(updateEventState.infoMap);
    }
    state = Loading();
    final response =
        await updateAnEventUsecase.execute(event: event, image: image);
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage, infoMap: map);
      }
    }, (event) {
      state = Loaded(event: event);
    });
    return state;
  }

  // Méthodes

  void updateKey(String key, dynamic value) {
    if (state is Initial) {
      final currentState = state as Initial;
      final updatedMap = Map<String, dynamic>.from(currentState.infoMap);
      updatedMap[key] = value;
      state = currentState.copyWith(infoMap: updatedMap);
    }
  }

  void reset(Map<String, dynamic>? map) {
    state = Initial(infoMap: map ?? INIT);
  }
}

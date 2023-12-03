import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/event_model.dart';
import '../entities/event.dart';

abstract class EventRepository {
  // Récupère tous les évènements
  Future<Either<Failure, List<Event>>?> fetchAllEvents();

  // Poste un évènement
  Future<Either<Failure, Event>?> postAnEvent({
    required EventModel event,
    required File image,
  });

  // Update un évènement
  Future<Either<Failure, Event>?> updateAnEvent({
    required EventModel event,
    required File image,
  });

  Future<Either<Failure, Event>?> activateAnEvent({required int eventId});
  Future<Either<Failure, Event>?> closeAnEvent({required int eventId});
}

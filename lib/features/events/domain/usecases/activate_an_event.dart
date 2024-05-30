// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';

class ActivateAnEvent {
  ActivateAnEvent({required this.repository});
  final EventRepository repository;

  Future<Either<Failure, Event>> execute({required int eventId}) async {
    return await repository.activateAnEvent(eventId: eventId);
  }
}

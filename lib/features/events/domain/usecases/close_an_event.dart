import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

class CloseAnEvent {
  CloseAnEvent({required this.repository});
  final EventRepository repository;

  Future<Either<Failure, Event>> execute({required int eventId}) async {
    return await repository.closeAnEvent(eventId: eventId);
  }
}

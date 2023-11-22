import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

class ActivateAnEvent {
  const ActivateAnEvent({required this.repository});
  final EventRepository repository;

  Future<Either<Failure, Event>?>? execute(
      {required Event event, required int userId}) {
    return repository.activateAnEvent(event: event, userId: userId);
  }
}

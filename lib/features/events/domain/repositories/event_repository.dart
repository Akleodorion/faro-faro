import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';

abstract class EventRepository {
  // Récupère tous les évènements
  Future<Either<Failure, List<Event>>?> fetchAllEvents();

  // Récupère des évènements au hasard
  Future<Either<Failure, List<Event>>?> fetchRandomEvents();

  // Récupère les évènements qui arrive à échéances
  Future<Either<Failure, List<Event>>> fetchUpcomingEvents();
}

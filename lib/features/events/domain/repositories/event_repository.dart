import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';

abstract class EventRepository {
  // Récupère les évènements en Tendance
  Future<Either<Failure, List<Event>>> fetchTrendingEvent();

  // Récupère les évènements qui arrive à échéances
  Future<Either<Failure, List<Event>>> fetchUpcomingEvent();
}

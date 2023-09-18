import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  // Récupère tous les évènements
  Future<Either<Failure, List<Event>>?> fetchAllEvents();
}

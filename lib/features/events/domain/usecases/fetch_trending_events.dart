import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

import '../../../../core/errors/failures.dart';

class FetchTrendingEvents {
  final EventRepository repository;

  FetchTrendingEvents({required this.repository});

  Future<Either<Failure, List<Event>>> execute() async {
    return await repository.fetchTrendingEvent();
  }
}

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

import '../../../../core/errors/failures.dart';

class FetchRandomEvents {
  final EventRepository repository;

  FetchRandomEvents({required this.repository});

  Future<Either<Failure, List<Event>>?> execute() async {
    return await repository.fetchRandomEvents();
  }
}

import 'package:dartz/dartz.dart';
import '../repositories/event_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/event.dart';

class FetchAllEvents {
  final EventRepository repository;
  FetchAllEvents({required this.repository});

  Future<Either<Failure, List<Event>>> execute() async {
    return repository.fetchAllEvents();
  }
}

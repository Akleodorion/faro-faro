import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/events/data/datasources/event_remote_data_source.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Event>>?> fetchAllEvents() async {
    if (await networkInfo.isConnected) {
      final events = await remoteDatasource.fetchAllEvents();
      // On stockera ici les events dans la mémoire cache

      //
      return Right(events);
    } else {
      return const Left(ServerFailure(errorMessage: "an error has occured"));
    }
  }

  @override
  Future<Either<Failure, List<Event>>?> fetchRandomEvents() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> fetchUpcomingEvents() {
    throw UnimplementedError();
  }
}

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/event_remote_data_source.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Event>>?> fetchAllEvents() async {
    try {
      if (await networkInfo.isConnected) {
        final events = await remoteDatasource.fetchAllEvents();
        return Right(events);
      } else {
        return const Left(ServerFailure(errorMessage: "No internet connexion"));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(errorMessage: error.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Event>?> postAnEvent(
      {required String title,
      required String description,
      required DateTime date,
      required String address,
      required double latitude,
      required double longitude,
      required Category category,
      required String imageUrl,
      required int userId,
      required ModelEco modelEco,
      required int standardTicketPrice,
      required int maxStandardTicket,
      required String standardTicketDescription,
      required int vipTicketPrice,
      required int maxVipTicket,
      required String vipTicketDescription,
      required int vvipTicketPrice,
      required int maxVvipTicket,
      required String vvipTicketDescription}) {
    // TODO: implement postAnEvent
    throw UnimplementedError();
  }
}

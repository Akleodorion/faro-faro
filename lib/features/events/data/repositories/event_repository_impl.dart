import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
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
      {required EventModel event, required File image}) async {
    try {
      if (await networkInfo.isConnected) {
        final myEvent =
            await remoteDatasource.postAnEvent(event: event, image: image);
        return Right(myEvent!);
      } else {
        return const Left(ServerFailure(errorMessage: 'No internet connexion'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(errorMessage: error.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Event>?> activateAnEvent(
      {required int eventId, required int userId}) {
    // TODO: implement activateAnEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Event>?> updateAnEvent(
      {required EventModel event, required File image}) {
    // TODO: implement updateAnEvent
    throw UnimplementedError();
  }
}

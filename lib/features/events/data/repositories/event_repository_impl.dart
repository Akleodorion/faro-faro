// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/features/events/data/models/event_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_data_source.dart';

typedef _PostOrUpdateEvent = Future<Event> Function();
typedef _ActivateOrCloseEvent = Future<Event> Function();
typedef _RemoteFucntion = Future<Event> Function();

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Event>>> fetchAllEvents() async {
    try {
      await networkInfo.getConnexionStatuts();
      return getEventList();
    } on ServerException catch (error) {
      return getServerFailures(error);
    }
  }

  Future<Right<Failure, List<Event>>> getEventList() async {
    final events = await remoteDatasource.fetchAllEvents();
    return Right(events);
  }

  Left<Failure, List<Event>> getServerFailures(ServerException error) {
    return Left(
      ServerFailure(errorMessage: error.errorMessage),
    );
  }

  @override
  Future<Either<Failure, Event>> postAnEvent(
      {required EventModel event, required File image}) async {
    return await _getPostOrUpdateEvent(
      () => remoteDatasource.postAnEvent(
        event: event,
        image: image,
      ),
    );
  }

  @override
  Future<Either<Failure, Event>> updateAnEvent(
      {required EventModel event, required File image}) async {
    return await _getPostOrUpdateEvent(
      () {
        return remoteDatasource.updateAnEvent(
          event: event,
          image: image,
        );
      },
    );
  }

  Future<Either<Failure, Event>> _getPostOrUpdateEvent(
      _PostOrUpdateEvent getPostOrUpdateEvent) async {
    try {
      await networkInfo.getConnexionStatuts();
      return await _getRemoteFunction(
        () => getPostOrUpdateEvent(),
      );
    } on ServerException catch (error) {
      return getServerFailure(error);
    }
  }

  Future<Right<Failure, Event>> _getRemoteFunction(
      _RemoteFucntion remoteFucntion) async {
    final event = await remoteFucntion();
    return Right(event);
  }

  Left<Failure, Event> getServerFailure(ServerException error) {
    return Left(
      ServerFailure(errorMessage: error.errorMessage),
    );
  }

  @override
  Future<Either<Failure, Event>> activateAnEvent({required int eventId}) async {
    return await _getActivateOrCloseEvent(
      eventId,
      () {
        return remoteDatasource.activateAnEvent(eventId: eventId);
      },
    );
  }

  @override
  Future<Either<Failure, Event>> closeAnEvent({required int eventId}) async {
    return await _getActivateOrCloseEvent(
      eventId,
      () {
        return remoteDatasource.closeAnEvent(eventId: eventId);
      },
    );
  }

  Future<Either<Failure, Event>> _getActivateOrCloseEvent(
      int eventId, _ActivateOrCloseEvent activateOrCloseEvent) async {
    try {
      await networkInfo.getConnexionStatuts();
      return await _getRemoteFunction(
        () => activateOrCloseEvent(),
      );
    } on ServerException catch (error) {
      return getServerFailure(error);
    }
  }
}

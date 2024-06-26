// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/core/network/network_info.dart';
import 'package:faro_faro/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_faro/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TicketRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Ticket>> createTicket(
      {required TicketModel ticket}) async {
    //check internet
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.createTicket(ticket: ticket);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(errorMessage: failure.errorMessage));
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }

  @override
  Future<Either<Failure, List<Ticket>>> fetchUserTickets(
      {required int userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.fetchUserTickets(userId: userId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(errorMessage: failure.errorMessage));
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }

  @override
  Future<Either<Failure, Ticket>> updateTicket(
      {required int userId, required int ticketId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateTicket(
            ticketId: ticketId, userId: userId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(errorMessage: failure.errorMessage));
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }

  @override
  Future<Either<Failure, String>> activateTicket(
      {required int userId, required TicketModel ticket}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.activateTicket(
            userId: userId, ticket: ticket);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(errorMessage: failure.errorMessage),
        );
      }
    }
    return const Left(
      ServerFailure(errorMessage: noInternetConnexion),
    );
  }
}

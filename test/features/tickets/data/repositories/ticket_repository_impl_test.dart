// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/core/network/network_info.dart';
import 'package:faro_faro/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_faro/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'ticket_repository_impl_test.mocks.dart';

@GenerateMocks([TicketRemoteDataSource, NetworkInfo])
void main() {
  late MockTicketRemoteDataSource mockTicketRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TicketRepositoryImpl sut;

  setUp(() {
    mockTicketRemoteDataSource = MockTicketRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    sut = TicketRepositoryImpl(
        remoteDataSource: mockTicketRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group(
    "createTicket",
    () {
      const tTicketModel = TicketModel(
        id: 1,
        type: Type.standard,
        description: "short description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false,
      );

      group(
        "if there is no internet connexion",
        () {
          test(
            "should return ServerFailure",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
              //act
              final result = await sut.createTicket(ticket: tTicketModel);
              //assert
              expect(
                result,
                const Left(
                  ServerFailure(errorMessage: noInternetConnexion),
                ),
              );
              verify(mockNetworkInfo.isConnected).called(1);
            },
          );
        },
      );

      group(
        "when there is an internet connexion",
        () {
          setUp(() =>
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));

          test(
            "should return a valid TicketModel if the call is successfull",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.createTicket(
                      ticket: anyNamed('ticket')))
                  .thenAnswer((_) async => tTicketModel);
              //act
              final result = await sut.createTicket(ticket: tTicketModel);
              //assert
              expect(result, const Right(tTicketModel));
              verify(mockNetworkInfo.isConnected).called(1);
              verify(mockTicketRemoteDataSource.createTicket(
                  ticket: tTicketModel));
            },
          );

          test(
            "should return a ServerFailure if the call is not successfull",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.createTicket(
                      ticket: anyNamed('ticket')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result = await sut.createTicket(ticket: tTicketModel);
              //assert
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
              verify(mockNetworkInfo.isConnected).called(1);
              verify(mockTicketRemoteDataSource.createTicket(
                  ticket: tTicketModel));
            },
          );
        },
      );
    },
  );

  group(
    "fetchUserTickets",
    () {
      const tUserId = 1;

      group('when there is no internet connexion', () {
        test(
          "should return ServerFailure ",
          () async {
            //arrange
            when(mockNetworkInfo.isConnected)
                .thenAnswer((realInvocation) async => false);
            //act
            final result = await sut.fetchUserTickets(userId: tUserId);
            //assert
            expect(result,
                const Left(ServerFailure(errorMessage: noInternetConnexion)));
          },
        );
      });

      group(
        "when there is an internet connexion",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));
          const tTicketModel1 = TicketModel(
            id: 1,
            type: Type.standard,
            description: "short description",
            eventId: 1,
            userId: 1,
            qrCodeUrl: "qrCodeUrl",
            verified: false,
          );
          const tTicketModel2 = TicketModel(
            id: 1,
            type: Type.standard,
            description: "short description",
            eventId: 1,
            userId: 1,
            qrCodeUrl: "qrCodeUrl",
            verified: false,
          );
          const List<TicketModel> tTickets = [tTicketModel1, tTicketModel2];

          test(
            "should return a valid TicketModel if the call is a success",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.fetchUserTickets(
                      userId: anyNamed('userId')))
                  .thenAnswer((realInvocation) async => tTickets);
              //act
              final result = await sut.fetchUserTickets(userId: tUserId);
              //assert
              expect(result, const Right(tTickets));
            },
          );

          test(
            "should return a ServerFailure is the call is not a success",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.fetchUserTickets(
                      userId: anyNamed('userId')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              final result = await sut.fetchUserTickets(userId: tUserId);
              //assert
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );
    },
  );

  group(
    "updateTicket",
    () {
      const tUserId = 1;
      const tTicketId = 1;
      const tTicketModel = TicketModel(
        id: 1,
        type: Type.standard,
        description: "short description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false,
      );
      group(
        "when there is no internet connexion.",
        () {
          test(
            "should return a Server Failure",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected)
                  .thenAnswer((realInvocation) async => false);
              //act
              final result =
                  await sut.updateTicket(userId: tUserId, ticketId: tTicketId);
              //assert
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
              verify(mockNetworkInfo.isConnected).called(1);
            },
          );
        },
      );

      group(
        "when there is a internet connexion",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));

          test(
            "should return a valid TicketModel if the call is a success",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.updateTicket(
                      ticketId: anyNamed(('ticketId')),
                      userId: anyNamed('userId')))
                  .thenAnswer((realInvocation) async => tTicketModel);
              //act
              final result =
                  await sut.updateTicket(ticketId: tTicketId, userId: tUserId);
              //assert
              expect(result, const Right(tTicketModel));
            },
          );

          test(
            "should return a ServerFailure if the call is not a success",
            () async {
              //arrange
              when(mockTicketRemoteDataSource.updateTicket(
                      ticketId: anyNamed(('ticketId')),
                      userId: anyNamed('userId')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result =
                  await sut.updateTicket(userId: tUserId, ticketId: tTicketId);
              //assert
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );
    },
  );

  group(
    "Activate Ticket",
    () {
      const int tUserId = 1;
      const TicketModel tTicket = TicketModel(
          id: 1,
          type: Type.standard,
          description: "description",
          eventId: 12,
          userId: 6,
          qrCodeUrl: "qrCodeUrl",
          verified: false);

      group(
        "When there is no internet connexion",
        () {
          setUp(() =>
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

          test(
            "should return ServerFailure",
            () async {
              //act
              final result =
                  await sut.activateTicket(ticket: tTicket, userId: tUserId);
              //assert
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
            },
          );
        },
      );

      group("when there is an internet connexion", () {
        setUp(() =>
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
        test("should return Right(String) if is a success", () async {
          // arrange
          when(mockTicketRemoteDataSource.activateTicket(
                  userId: anyNamed('userId'), ticket: anyNamed('ticket')))
              .thenAnswer((_) async => "String");
          // act
          final result =
              await sut.activateTicket(userId: tUserId, ticket: tTicket);
          // assert
          expect(result, const Right("String"));
        });

        test("should return Left(ServerFailure) if is not a success", () async {
          // arrange
          when(mockTicketRemoteDataSource.activateTicket(
                  userId: anyNamed('userId'), ticket: anyNamed('ticket')))
              .thenThrow(ServerException(errorMessage: "oops"));
          // act
          final result =
              await sut.activateTicket(userId: tUserId, ticket: tTicket);
          // assert
          expect(result, const Left(ServerFailure(errorMessage: "oops")));
        });
      });
    },
  );
}

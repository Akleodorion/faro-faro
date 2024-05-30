// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:faro_faro/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'fetch_user_tickets_usecase_test.mocks.dart';

@GenerateMocks([TicketRepository])
void main() {
  late MockTicketRepository mockTicketRepository;
  late FetchUserTicketsUsecase sut;

  setUp(() {
    mockTicketRepository = MockTicketRepository();
    sut = FetchUserTicketsUsecase(repository: mockTicketRepository);
  });

  group(
    "Execute",
    () {
      const tUserId = 1;
      const tTicket1 = Ticket(
          id: 1,
          type: Type.standard,
          description: "short description",
          eventId: 1,
          userId: 1,
          qrCodeUrl: "qrCodeUrl",
          verified: false);
      const tTicket2 = Ticket(
          id: 2,
          type: Type.standard,
          description: "short description",
          eventId: 1,
          userId: 1,
          qrCodeUrl: "qrCodeUrl",
          verified: false);
      const tTickets = [
        tTicket1,
        tTicket2,
      ];
      test(
        "should return a valid Ticket if the call is a success",
        () async {
          //arrange
          when(mockTicketRepository.fetchUserTickets(
                  userId: anyNamed('userId')))
              .thenAnswer((realInvocation) async => const Right(tTickets));
          //act
          final result = await sut.execute(userId: tUserId);
          //assert
          expect(result, const Right(tTickets));
        },
      );

      test(
        "should return a Server Failure if the call is not successfull",
        () async {
          //arrange
          when(mockTicketRepository.fetchUserTickets(
                  userId: anyNamed('userId')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(userId: tUserId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    },
  );
}

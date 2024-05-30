// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:faro_faro/features/tickets/domain/usecases/update_ticket_usecase.dart';
import 'update_ticket_usecase_test.mocks.dart';

@GenerateMocks([TicketRepository])
void main() {
  late MockTicketRepository mockTicketRepository;
  late UpdateTicketUsecase sut;

  setUp(() {
    mockTicketRepository = MockTicketRepository();
    sut = UpdateTicketUsecase(repository: mockTicketRepository);
  });

  group(
    "Execute",
    () {
      const tUserId = 1;
      const tTicket = Ticket(
          id: 1,
          type: Type.standard,
          description: "short description",
          eventId: 1,
          userId: 1,
          qrCodeUrl: "qrCodeUrl",
          verified: false);
      test(
        "should return a valid Ticket if the call is a success",
        () async {
          //arrange
          when(mockTicketRepository.updateTicket(
                  userId: anyNamed('userId'), ticketId: anyNamed('ticketId')))
              .thenAnswer((realInvocation) async => const Right(tTicket));
          //act
          final result =
              await sut.execute(ticketId: tTicket.id ?? 1, userId: tUserId);
          //assert
          expect(result, const Right(tTicket));
        },
      );

      test(
        "should return a Server Failure if the call is not successfull",
        () async {
          //arrange
          when(mockTicketRepository.updateTicket(
                  userId: anyNamed('userId'), ticketId: anyNamed(('ticketId'))))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result =
              await sut.execute(ticketId: tTicket.id ?? 1, userId: tUserId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    },
  );
}

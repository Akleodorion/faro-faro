// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:faro_faro/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'create_ticket_usecase_test.mocks.dart';

@GenerateMocks([TicketRepository])
void main() {
  late MockTicketRepository mockTicketRepository;
  late CreateTicketUsecase sut;

  setUp(() {
    mockTicketRepository = MockTicketRepository();
    sut = CreateTicketUsecase(repository: mockTicketRepository);
  });

  group(
    "Execute",
    () {
      const tTicket = TicketModel(
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
          when(mockTicketRepository.createTicket(ticket: anyNamed('ticket')))
              .thenAnswer((realInvocation) async => const Right(tTicket));
          //act
          final result = await sut.execute(ticket: tTicket);
          //assert
          expect(result, const Right(tTicket));
        },
      );

      test(
        "should return a Server Failure if the call is not successfull",
        () async {
          //arrange
          when(mockTicketRepository.createTicket(ticket: anyNamed('ticket')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(ticket: tTicket);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    },
  );
}

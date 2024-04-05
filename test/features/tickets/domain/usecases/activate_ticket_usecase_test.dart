import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/activate_ticket_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'activate_ticket_usecase_test.mocks.dart';

@GenerateMocks([TicketRepository])
void main() {
  late MockTicketRepository mockTicketRepository;
  late ActivateTicketUsecase sut;
  setUp(() {
    mockTicketRepository = MockTicketRepository();
    sut = ActivateTicketUsecase(repository: mockTicketRepository);
  });

  group("Activate Ticket", () {
    const int tUserId = 12;
    const TicketModel tTicket = TicketModel(
      id: 1,
      type: Type.standard,
      description: "description",
      eventId: 16,
      userId: 1,
      qrCodeUrl: "qrCodeUrl",
      verified: false,
    );
    test("Should return a string when the call is a success", () async {
      //arrange
      when(mockTicketRepository.activateTicket(
              userId: anyNamed("userId"), ticket: anyNamed("ticket")))
          .thenAnswer((_) async => const Right("string"));

      //act
      final result = await sut.execute(userId: tUserId, ticket: tTicket);
      //assert
      expect(
        result,
        const Right("string"),
      );
    });

    test("Should return a Failure when the call is not a success", () async {
      //arrange
      when(mockTicketRepository.activateTicket(
              userId: anyNamed("userId"), ticket: anyNamed("ticket")))
          .thenAnswer(
              (_) async => const Left(ServerFailure(errorMessage: "oops")));

      //act
      final result = await sut.execute(userId: tUserId, ticket: tTicket);
      //assert
      expect(
        result,
        const Left(ServerFailure(errorMessage: "oops")),
      );
    });
  });
}

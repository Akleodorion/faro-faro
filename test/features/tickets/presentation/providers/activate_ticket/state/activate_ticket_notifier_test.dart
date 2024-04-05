import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/activate_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'activate_ticket_notifier_test.mocks.dart';

@GenerateMocks([ActivateTicketUsecase])
void main() {
  late MockActivateTicketUsecase mockActivateTicketUsecase;
  late ActivateTicketNotifier sut;

  setUp(() {
    mockActivateTicketUsecase = MockActivateTicketUsecase();
    sut = ActivateTicketNotifier(usecase: mockActivateTicketUsecase);
  });

  test("should get Initial", () {
    // assert
    expect(sut.initialState, Initial());
  });

  group("Activate Ticket", () {
    const tUserId = 1;
    const tTicket = TicketModel(
        id: 1,
        type: Type.gold,
        description: "description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: true);
    test("should emit [Loading, Loaded] if the request is successful",
        () async {
      // arrange
      when(mockActivateTicketUsecase.execute(userId: tUserId, ticket: tTicket))
          .thenAnswer((realInvocation) async => const Right("string"));
      // assert later
      final expectedEmit = [Loading(), Loaded(message: "success")];
      expect(sut.stream, emitsInOrder(expectedEmit));
      // act

      await sut.activateTicket(userId: tUserId, ticket: tTicket);
    });

    test("should emit [Loading, Error] if the request is unsuccessful",
        () async {
      // arrange
      when(mockActivateTicketUsecase.execute(userId: tUserId, ticket: tTicket))
          .thenAnswer((realInvocation) async =>
              const Left(ServerFailure(errorMessage: "oops")));
      // assert later
      final expectedEmit = [Loading(), Error(message: "oops")];
      expect(sut.stream, emitsInOrder(expectedEmit));
      // act

      await sut.activateTicket(userId: tUserId, ticket: tTicket);
    });
  });
}

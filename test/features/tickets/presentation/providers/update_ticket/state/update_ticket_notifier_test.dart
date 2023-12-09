import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/update_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_ticket_notifier_test.mocks.dart';

@GenerateMocks([UpdateTicketUsecase])
void main() {
  late MockUpdateTicketUsecase mockUpdateTicketUsecase;
  late UpdateTicketNotifier sut;

  setUp(() {
    mockUpdateTicketUsecase = MockUpdateTicketUsecase();
    sut = UpdateTicketNotifier(usecase: mockUpdateTicketUsecase);
  });

  test(
    "should get the initial state",
    () async {
      //assert
      expect(sut.initial, Initial());
    },
  );

  group(
    "createTicket",
    () {
      const tUserId = 1;
      const tTicketId = 1;
      const tSuccessMessage = "Réussi";
      const tTicket = TicketModel(
          id: 1,
          type: Type.standard,
          description: "short description",
          eventId: 1,
          userId: 1,
          qrCodeUrl: "qrCodeUrl",
          verified: false);
      test(
        "should emit [Loading, Loaded] if the call is successfull",
        () async {
          //arrange
          when(mockUpdateTicketUsecase.execute(
                  ticketId: anyNamed('ticketId'), userId: anyNamed('userId')))
              .thenAnswer((realInvocation) async => const Right(tTicket));

          //assert later
          final expectedResult = [
            Loading(),
            Loaded(
              ticket: tTicket,
              message: tSuccessMessage,
            )
          ];
          expectLater(sut.stream, emitsInOrder(expectedResult));

          //act
          sut.updateTicket(userId: tUserId, ticketId: tTicketId);
          verify(mockUpdateTicketUsecase.execute(
                  ticketId: tTicketId, userId: tUserId))
              .called(1);
        },
      );

      test(
        "should emit [Loading, Loaded] if the call is successfull",
        () async {
          //arrange
          when(mockUpdateTicketUsecase.execute(
                  ticketId: anyNamed('ticketId'), userId: anyNamed('userId')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));

          //assert later
          final expectedResult = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedResult));

          //act
          sut.updateTicket(userId: tUserId, ticketId: tTicketId);
          verify(mockUpdateTicketUsecase.execute(
                  ticketId: tTicketId, userId: tUserId))
              .called(1);
        },
      );
    },
  );
}

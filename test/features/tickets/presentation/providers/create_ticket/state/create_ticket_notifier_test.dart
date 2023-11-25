import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_ticket_notifier_test.mocks.dart';

@GenerateMocks([CreateTicketUsecase])
void main() {
  late MockCreateTicketUsecase mockCreateTicketUsecase;
  late CreateTicketNotifier sut;

  setUp(() {
    mockCreateTicketUsecase = MockCreateTicketUsecase();
    sut = CreateTicketNotifier(usecase: mockCreateTicketUsecase);
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
      const tTicket = TicketModel(
          id: 1,
          type: Type.standard,
          description: "short description",
          eventId: 1,
          userId: 1,
          verified: false);
      test(
        "should emit [Loading, Loaded] if the call is successfull",
        () async {
          //arrange
          when(mockCreateTicketUsecase.execute(ticket: anyNamed('ticket')))
              .thenAnswer((_) async => const Right(tTicket));

          //assert later
          final expectedResult = [Loading(), Loaded(ticket: tTicket)];
          expectLater(sut.stream, emitsInOrder(expectedResult));

          //act
          sut.createTicket(ticket: tTicket);
          verify(mockCreateTicketUsecase.execute(ticket: tTicket)).called(1);
        },
      );

      test(
        "should emit [Loading, Error] if the call is successfull",
        () async {
          //arrange
          when(mockCreateTicketUsecase.execute(ticket: anyNamed('ticket')))
              .thenAnswer(
                  (_) async => const Left(ServerFailure(errorMessage: 'oops')));

          //assert later
          final expectedResult = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedResult));

          //act
          sut.createTicket(ticket: tTicket);
          verify(mockCreateTicketUsecase.execute(ticket: tTicket)).called(1);
        },
      );
    },
  );
}

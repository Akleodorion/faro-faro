import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_tickets_notifier_test.mocks.dart';

@GenerateMocks([FetchUserTicketsUsecase])
void main() {
  late MockFetchUserTicketsUsecase mockFetchUserTicketsUsecase;
  late FetchTicketsNotifier sut;

  setUp(() {
    mockFetchUserTicketsUsecase = MockFetchUserTicketsUsecase();
    sut = FetchTicketsNotifier(usecase: mockFetchUserTicketsUsecase);
  });

  test(
    "should return the initial state ",
    () async {
      //act
      //assert
      expect(sut.initial, Loading());
    },
  );

  group("fetchUserTickets", () {
    const tUserId = 1;
    const tSuccessMessage = "Réussi";
    const tTicket = TicketModel(
        id: 1,
        type: Type.standard,
        description: "short description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTickets = [tTicket];
    test(
      "should emit in order [Loaded] if the call is a success",
      () async {
        //arrange
        when(mockFetchUserTicketsUsecase.execute(userId: anyNamed('userId')))
            .thenAnswer((realInvocation) async => const Right(tTickets));
        //act
        final expectedResult = [
          Loaded(tickets: tTickets, message: tSuccessMessage)
        ];
        expectLater(sut.stream, emitsInOrder(expectedResult));
        //assert
        sut.fetchUserTickets(userId: tUserId);
      },
    );

    test(
      "should emit in order [Error] if the call is a success",
      () async {
        //arrange
        when(mockFetchUserTicketsUsecase.execute(userId: anyNamed('userId')))
            .thenAnswer((realInvocation) async =>
                const Left(ServerFailure(errorMessage: 'oops')));
        //act
        final expectedResult = [Error(message: 'oops')];
        expectLater(sut.stream, emitsInOrder(expectedResult));
        //assert
        sut.fetchUserTickets(userId: tUserId);
      },
    );
  });
}

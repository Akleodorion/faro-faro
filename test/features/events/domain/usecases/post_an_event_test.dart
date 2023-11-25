import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late PostAnEvent postAnEvent;

  setUp(() {
    mockEventRepository = MockEventRepository();
    postAnEvent = PostAnEvent(repository: mockEventRepository);
  });

  group('Execute', () {
    const tTicket1 = Ticket(
        id: 1,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 1,
        verified: false);
    const tTicket2 = Ticket(
        id: 2,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 2,
        verified: false);
    const tTickets = [tTicket1, tTicket2];
    const tMember1 = Member(id: 1, userId: 1, eventId: 1);
    const tMember2 = Member(id: 2, userId: 2, eventId: 1);
    const tMembers = [tMember1, tMember2];
    final tEvent = EventModel(
      name: "My test event",
      eventId: 20,
      description: "Short description for the test event !",
      date: DateTime.now(),
      address: const Address(
          latitude: 10.5264,
          longitude: 20.4585,
          addressName: "addressName",
          geocodeUrl: "geocodeUrl"),
      category: Category.concert,
      imageUrl: "flyers.jpg",
      userId: 1,
      modelEco: ModelEco.gratuit,
      members: tMembers,
      tickets: tTickets,
      activated: false,
      standardTicketPrice: 5000,
      maxStandardTicket: 15,
      standardTicketDescription: "Short ticket description for the test",
      goldTicketPrice: 10000,
      maxGoldTicket: 25,
      goldTicketDescription: "vip ticket simple description",
      platinumTicketPrice: 15000,
      maxPlatinumTicket: 10,
      platinumTicketDescription: "vvip ticket simple description",
    );

    final tImage = File('flyers.jpg');

    test(
      "should return the newly created Event",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(event: tEvent, image: tImage))
            .thenAnswer((_) async => Right(tEvent));
        //act
        final result = await postAnEvent.execute(event: tEvent, image: tImage);
        //assert
        expect(result, Right(tEvent));
      },
    );

    test(
      "should return Left Failure message is unsuccessful",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(event: tEvent, image: tImage))
            .thenAnswer(
                (_) async => const Left(ServerFailure(errorMessage: 'oops')));
        //act
        final result = await postAnEvent.execute(event: tEvent, image: tImage);
        //assert
        expect(result, const Left(ServerFailure(errorMessage: 'oops')));
      },
    );
  });
}

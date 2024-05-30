// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/events/data/models/event_model.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';
import 'package:faro_faro/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
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
    const tTicket1 = TicketModel(
        id: 1,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTicket2 = TicketModel(
        id: 2,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 2,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTickets = [tTicket1, tTicket2];
    const tMember1 =
        MemberModel(id: 1, userId: 1, eventId: 1, username: "test");
    const tMember2 =
        MemberModel(id: 2, userId: 2, eventId: 1, username: "test2");
    const tMembers = [tMember1, tMember2];
    final tEvent = EventModel(
      name: "My test event",
      id: 20,
      description: "Short description for the test event !",
      date: DateTime.now(),
      startTime: const TimeOfDay(hour: 18, minute: 00),
      endTime: const TimeOfDay(hour: 18, minute: 00),
      address: const Address(
          latitude: 4.7,
          longitude: -3.9,
          geocodeUrl: "geocodeUrl",
          country: "Côte d'Ivoire",
          countryCode: "CI",
          locality: "Abidjan",
          plusCode: "9359+HXR",
          road: "Route d'Abatta",
          sublocality: "Cocody"),
      category: Category.concert,
      imageUrl: "flyers.jpg",
      userId: 1,
      modelEco: ModelEco.gratuit,
      members: tMembers,
      tickets: tTickets,
      activated: false,
      closed: false,
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

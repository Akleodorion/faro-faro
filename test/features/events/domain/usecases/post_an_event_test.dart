import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
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
    const tTitle = "My test event";
    const tDescription = "Short description for the test event !";
    final tDate = DateTime.now();
    const tAddress = "Lille";
    const tLongitude = -127.5345;
    const tLatitude = 42.54596;
    const tCategory = Category.concert;
    const tImageUrl = "flyers.jpg";
    const tUserId = 1;
    const tModelEco = ModelEco.gratuit;
    const tStandardTicketPrice = 5000;
    const tMaxStandardTicket = 15;
    const tStandardTicketDescription = "Short ticket description for the test";
    const tVipTicketPrice = 5000;
    const tMaxVipTicket = 15;
    const tVipTicketDescription = "Short ticket description for the test";
    const tVvipTicketPrice = 5000;
    const tMaxVvipTicket = 15;
    const tVvipTicketDescription = "Short ticket description for the test";

    final tEvent = Event(
        name: tTitle,
        eventId: 20,
        description: tDescription,
        date: tDate,
        address: tAddress,
        latitude: tLatitude,
        longitude: tLongitude,
        category: tCategory,
        imageUrl: tImageUrl,
        userId: tUserId,
        modelEco: tModelEco,
        standardTicketPrice: tStandardTicketPrice,
        maxStandardTicket: tMaxStandardTicket,
        standardTicketDescription: tStandardTicketDescription,
        vipTicketPrice: tVipTicketPrice,
        maxVipTicket: tMaxVipTicket,
        vipTicketDescription: tVipTicketDescription,
        vvipTicketPrice: tVvipTicketPrice,
        maxVvipTicket: tMaxVvipTicket,
        vvipTicketDescription: tVvipTicketDescription);

    test(
      "should return the newly created Event",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(
                title: tTitle,
                description: tDescription,
                date: tDate,
                address: tAddress,
                longitude: tLongitude,
                latitude: tLatitude,
                category: tCategory,
                imageUrl: tImageUrl,
                userId: tUserId,
                modelEco: tModelEco,
                standardTicketPrice: tStandardTicketPrice,
                maxStandardTicket: tMaxStandardTicket,
                standardTicketDescription: tStandardTicketDescription,
                vipTicketPrice: tVipTicketPrice,
                maxVipTicket: tMaxVipTicket,
                vipTicketDescription: tVipTicketDescription,
                vvipTicketPrice: tVvipTicketPrice,
                maxVvipTicket: tMaxVvipTicket,
                vvipTicketDescription: tVvipTicketDescription))
            .thenAnswer((_) async => Right(tEvent));
        //act
        final result = await postAnEvent.execute(
            title: tTitle,
            description: tDescription,
            date: tDate,
            address: tAddress,
            longitude: tLongitude,
            latitude: tLatitude,
            category: tCategory,
            imageUrl: tImageUrl,
            userId: tUserId,
            modelEco: tModelEco,
            standardTicketPrice: tStandardTicketPrice,
            maxStandardTicket: tMaxStandardTicket,
            standardTicketDescription: tStandardTicketDescription,
            vipTicketPrice: tVipTicketPrice,
            maxVipTicket: tMaxVipTicket,
            vipTicketDescription: tVipTicketDescription,
            vvipTicketPrice: tVvipTicketPrice,
            maxVvipTicket: tMaxVvipTicket,
            vvipTicketDescription: tVvipTicketDescription);
        //assert
        expect(result, Right(tEvent));
      },
    );

    test(
      "should return Left Failure message is unsuccessful",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(
                title: tTitle,
                description: tDescription,
                date: tDate,
                address: tAddress,
                longitude: tLongitude,
                latitude: tLatitude,
                category: tCategory,
                imageUrl: tImageUrl,
                userId: tUserId,
                modelEco: tModelEco,
                standardTicketPrice: tStandardTicketPrice,
                maxStandardTicket: tMaxStandardTicket,
                standardTicketDescription: tStandardTicketDescription,
                vipTicketPrice: tVipTicketPrice,
                maxVipTicket: tMaxVipTicket,
                vipTicketDescription: tVipTicketDescription,
                vvipTicketPrice: tVvipTicketPrice,
                maxVvipTicket: tMaxVvipTicket,
                vvipTicketDescription: tVvipTicketDescription))
            .thenAnswer(
                (_) async => const Left(ServerFailure(errorMessage: 'oops')));
        //act
        final result = await postAnEvent.execute(
            title: tTitle,
            description: tDescription,
            date: tDate,
            address: tAddress,
            longitude: tLongitude,
            latitude: tLatitude,
            category: tCategory,
            imageUrl: tImageUrl,
            userId: tUserId,
            modelEco: tModelEco,
            standardTicketPrice: tStandardTicketPrice,
            maxStandardTicket: tMaxStandardTicket,
            standardTicketDescription: tStandardTicketDescription,
            vipTicketPrice: tVipTicketPrice,
            maxVipTicket: tMaxVipTicket,
            vipTicketDescription: tVipTicketDescription,
            vvipTicketPrice: tVvipTicketPrice,
            maxVvipTicket: tMaxVvipTicket,
            vvipTicketDescription: tVvipTicketDescription);
        //assert
        expect(result, const Left(ServerFailure(errorMessage: 'oops')));
      },
    );
  });
}

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/address/domain/repositories/address_repository.dart';
import 'package:faro_faro/features/address/domain/usecases/get_current_location_address.dart';
import 'get_current_location_address_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockAddressRepository;
  late GetCurrentLocationAddress getCurrentLocationAddress;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    getCurrentLocationAddress =
        GetCurrentLocationAddress(repository: mockAddressRepository);
  });

  group('getCurrentLocationAddress', () {
    const tAddress = Address(
        latitude: 4.7,
        longitude: -3.9,
        geocodeUrl: "geocodeUrl",
        country: "Côte d'Ivoire",
        countryCode: "CI",
        locality: "Abidjan",
        plusCode: "9359+HXR",
        road: "Route d'Abatta",
        sublocality: "Cocody");

    test(
      "should return a valid Address model",
      () async {
        //arrange
        when(mockAddressRepository.getCurrentLocationAddress())
            .thenAnswer((_) async => const Right(tAddress));
        //act
        final result = await getCurrentLocationAddress.call();
        //assert
        expect(result, const Right(tAddress));
      },
    );
  });
}

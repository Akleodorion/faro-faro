import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/address/domain/repositories/address_repository.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_selected_location_address_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockAddressRepository;
  late GetSelectedLocationAddress getSelectedLocationAddress;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    getSelectedLocationAddress =
        GetSelectedLocationAddress(repository: mockAddressRepository);
  });

  group('getSelectedLocationAddress', () {
    const tLatitude = 12.52;
    const tLongitude = 52.45;
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
      "should return a valid address model",
      () async {
        //arrange
        when(mockAddressRepository.getSelectedLocationAddress(
                tLatitude, tLongitude))
            .thenAnswer((_) async => const Right(tAddress));
        //act
        final result =
            await getSelectedLocationAddress.call(tLatitude, tLongitude);
        //assert
        expect(result, const Right(tAddress));
      },
    );
  });
}

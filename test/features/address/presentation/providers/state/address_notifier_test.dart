// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/address/domain/usecases/get_current_location_address.dart';
import 'package:faro_faro/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:faro_faro/features/address/presentation/providers/state/address_notifier.dart';
import 'package:faro_faro/features/address/presentation/providers/state/address_state.dart';
import 'address_notifier_test.mocks.dart';

@GenerateMocks([GetCurrentLocationAddress, GetSelectedLocationAddress])
void main() {
  late MockGetCurrentLocationAddress mockGetCurrentLocationAddress;
  late MockGetSelectedLocationAddress mockGetSelectedLocationAddress;
  late AddressNotifier addressNotifier;

  setUp(() {
    mockGetCurrentLocationAddress = MockGetCurrentLocationAddress();
    mockGetSelectedLocationAddress = MockGetSelectedLocationAddress();
    addressNotifier = AddressNotifier(
        getCurrentLocationAddressUsecase: mockGetCurrentLocationAddress,
        getSelectedLocationAddressUsecase: mockGetSelectedLocationAddress);
  });

  test(
    "should be equal to Initial",
    () async {
      //assert
      expect(addressNotifier.initialState, Initial());
    },
  );

  group('getCurrentLocationAddress', () {
    const tAddress = Address(
        latitude: 4.7,
        longitude: -3.9,
        geocodeUrl: '',
        country: "Côte d'Ivoire",
        countryCode: "CI",
        locality: "Abidjan",
        plusCode: "9359+HXR",
        road: "Route d'Abatta",
        sublocality: "Cocody");
    const tSuccessMessage = "Addresse modifiée avec succès";
    test(
      "should call the usecase",
      () async {
        //arrange
        when(mockGetCurrentLocationAddress.call())
            .thenAnswer((_) async => const Right(tAddress));
        //act
        await addressNotifier.getCurrentLocationAddress();
        //assert
        verify(mockGetCurrentLocationAddress.call()).called(1);
      },
    );

    test(
      "should Emit [ Loading, Loaded] when the usecase is successfull",
      () async {
        //arrange
        when(mockGetCurrentLocationAddress.call())
            .thenAnswer((_) async => const Right(tAddress));
        //act
        final expectedState = [
          Loading(),
          Loaded(address: tAddress, message: tSuccessMessage)
        ];
        expectLater(addressNotifier.stream, emitsInOrder(expectedState));
        //assert
        addressNotifier.getCurrentLocationAddress();
      },
    );

    test(
      "should Emit [ Loading, Error] when the usecase is unsuccessfull",
      () async {
        //arrange
        when(mockGetCurrentLocationAddress.call()).thenAnswer((_) async =>
            const Left(ServerFailure(errorMessage: 'errorMessage')));
        //act
        final expectedState = [Loading(), Error(message: 'errorMessage')];
        expectLater(addressNotifier.stream, emitsInOrder(expectedState));
        //assert
        addressNotifier.getCurrentLocationAddress();
      },
    );
  });

  group('getSelectedLociationAddress', () {
    const tSuccessMessage = "Addresse modifiée avec succès";
    const tLatitude = 52.45456;
    const tLongitude = 44.54245;
    const tAddress = Address(
        latitude: tLatitude,
        longitude: tLongitude,
        geocodeUrl: '',
        country: "Côte d'Ivoire",
        countryCode: "CI",
        locality: "Abidjan",
        plusCode: "9359+HXR",
        road: "Route d'Abatta",
        sublocality: "Cocody");
    test(
      "should call the usecase",
      () async {
        //arrange
        when(mockGetSelectedLocationAddress.call(any, any))
            .thenAnswer((_) async => const Right(tAddress));
        //act
        await addressNotifier.getSelectedLocationAddressUsecase(
            tLatitude, tLongitude);
        //assert
        verify(mockGetSelectedLocationAddress.call(tLatitude, tLongitude))
            .called(1);
      },
    );

    test(
      "should Emit [ Loading, Loaded] when the usecase is successfull",
      () async {
        //arrange
        when(mockGetSelectedLocationAddress.call(any, any))
            .thenAnswer((_) async => const Right(tAddress));
        //act
        final expectedState = [
          Loading(),
          Loaded(address: tAddress, message: tSuccessMessage)
        ];
        expectLater(addressNotifier.stream, emitsInOrder(expectedState));
        //assert
        addressNotifier.getSelectedLociationAddress(tLatitude, tLongitude);
      },
    );

    test(
      "should Emit [ Loading, Error] when the usecase is unsuccessfull",
      () async {
        //arrange
        when(mockGetSelectedLocationAddress.call(any, any)).thenAnswer(
            (_) async =>
                const Left(ServerFailure(errorMessage: 'errorMessage')));
        //act
        final expectedState = [Loading(), Error(message: 'errorMessage')];
        expectLater(addressNotifier.stream, emitsInOrder(expectedState));
        //assert
        addressNotifier.getSelectedLociationAddress(tLatitude, tLongitude);
      },
    );
  });
}

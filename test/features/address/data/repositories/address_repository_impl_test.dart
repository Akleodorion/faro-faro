// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/address/data/datasources/address_remote_data_source.dart';
import 'package:faro_faro/features/address/data/models/address_model.dart';
import 'package:faro_faro/features/address/data/repositories/address_repository_impl.dart';
import 'address_repository_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSource])
void main() {
  late MockAddressRemoteDataSource mockAddressRemoteDataSource;
  late AddressRepositoryImpl addressRepositoryImpl;

  setUp(() {
    mockAddressRemoteDataSource = MockAddressRemoteDataSource();
    addressRepositoryImpl =
        AddressRepositoryImpl(remoteDataSource: mockAddressRemoteDataSource);
  });

  group(
    "getCurrentLocationAddress",
    () {
      const tAddressModel = AddressModel(
          latitude: 4.7,
          longitude: -3.9,
          geocodeUrl: 'https://maps.googleapis.com',
          country: "Côte d'Ivoire",
          countryCode: "CI",
          locality: "Abidjan",
          plusCode: "9359+HXR",
          road: "Route d'Abatta",
          sublocality: "Cocody");
      test(
        "should return a ServerFailure if the request is unsuccesfull",
        () async {
          //arrange
          when(mockAddressRemoteDataSource
                  .fetchAddressDataFromCurrentLocation())
              .thenThrow(ServerException(errorMessage: 'errorMessage'));
          //act
          final result =
              await addressRepositoryImpl.getCurrentLocationAddress();
          //assert
          verify(mockAddressRemoteDataSource
                  .fetchAddressDataFromCurrentLocation())
              .called(1);
          expect(
              result, const Left(ServerFailure(errorMessage: 'errorMessage')));
        },
      );

      test(
        "should return a valid AddressModel when the request is successfull",
        () async {
          //arrange
          when(mockAddressRemoteDataSource
                  .fetchAddressDataFromCurrentLocation())
              .thenAnswer((_) async => tAddressModel);
          //act
          final result =
              await addressRepositoryImpl.getCurrentLocationAddress();
          //assert
          verify(mockAddressRemoteDataSource
                  .fetchAddressDataFromCurrentLocation())
              .called(1);
          expect(result, const Right(tAddressModel));
        },
      );
    },
  );

  group(
    "getSelectedLocationAddress",
    () {
      const tLatitude = 52.45254;
      const tLongitude = 44.45456;
      const tAddressModel = AddressModel(
          latitude: tLatitude,
          longitude: tLongitude,
          geocodeUrl: 'https://maps.googleapis.com',
          country: "Côte d'Ivoire",
          countryCode: "CI",
          locality: "Abidjan",
          plusCode: "9359+HXR",
          road: "Route d'Abatta",
          sublocality: "Cocody");
      test(
        "should return a ServerFailure if the request is unsuccesfull",
        () async {
          //arrange
          when(mockAddressRemoteDataSource.fetchAddressDataFromMap(any, any))
              .thenThrow(ServerException(errorMessage: 'errorMessage'));
          //act
          final result = await addressRepositoryImpl.getSelectedLocationAddress(
              tLatitude, tLongitude);
          //assert
          verify(mockAddressRemoteDataSource.fetchAddressDataFromMap(
                  tLatitude, tLongitude))
              .called(1);
          expect(
              result, const Left(ServerFailure(errorMessage: 'errorMessage')));
        },
      );

      test(
        "should return a valid AddressModel when the request is successfull",
        () async {
          //arrange
          when(mockAddressRemoteDataSource.fetchAddressDataFromMap(any, any))
              .thenAnswer((_) async => tAddressModel);
          //act
          final result = await addressRepositoryImpl.getSelectedLocationAddress(
              tLatitude, tLongitude);
          //assert
          verify(mockAddressRemoteDataSource.fetchAddressDataFromMap(
                  tLatitude, tLongitude))
              .called(1);
          expect(result, const Right(tAddressModel));
        },
      );
    },
  );
}

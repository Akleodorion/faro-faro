import 'package:faro_clean_tdd/core/util/get_location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

import 'get_location_test.mocks.dart';

@GenerateMocks([Location])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLocation mockLocation;
  late GetLocationImpl getLocationImpl;

  setUp(() {
    mockLocation = MockLocation();
    getLocationImpl = GetLocationImpl(location: mockLocation);
  });

  group('getLocation', () {
    group(
      "when the service is enabled",
      () {
        setUp(() {
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
        });

        group('when the permission is not given', () {
          setUp(() {
            when(mockLocation.hasPermission())
                .thenAnswer((_) async => PermissionStatus.denied);
          });

          test(
            "should return null if the permission is not granted",
            () async {
              //arrange
              when(mockLocation.requestPermission())
                  .thenAnswer((_) async => PermissionStatus.denied);
              //act
              final result = await getLocationImpl.getLocation();
              //assert
              verify(mockLocation.hasPermission()).called(1);
              verify(mockLocation.requestPermission()).called(1);
              expect(result, null);
            },
          );
        });

        group('when the permission is granted', () {
          setUp(() {
            when(mockLocation.hasPermission())
                .thenAnswer((_) async => PermissionStatus.granted);
          });

          final LocationData tLocationData = LocationData.fromMap(
              {'longitude': 59.52545, 'latitude': 44.5265544});
          final tLocation = {
            'latitude': tLocationData.latitude,
            'longitude': tLocationData.longitude
          };
          test(
            "should retrieve the location data",
            () async {
              //arrange
              when(mockLocation.getLocation())
                  .thenAnswer((realInvocation) async => tLocationData);
              //act
              final result = await getLocationImpl.getLocation();
              //assert
              verify(mockLocation.getLocation());
              expect(result, tLocation);
            },
          );
        });
      },
    );
    group(
      "when the service is not enabled",
      () {
        setUp(() =>
            when(mockLocation.serviceEnabled()).thenAnswer((_) async => false));
        test(
          "should ask for permission",
          () async {
            //arrange
            when(mockLocation.requestService()).thenAnswer((_) async => false);
            //act
            await getLocationImpl.getLocation();
            //assert
            verify(mockLocation.serviceEnabled()).called(1);
            verify(mockLocation.requestService()).called(1);
          },
        );

        test(
          "should return null if the permission is not granted",
          () async {
            //arrange
            when(mockLocation.requestService()).thenAnswer((_) async => false);
            //act
            final result = await getLocationImpl.getLocation();
            //assert
            expect(result, null);
          },
        );
      },
    );
  });
}

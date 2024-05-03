import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/location/location_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_repo_test.mocks.dart';

@GenerateMocks([Location])
void main() {
  late MockLocation mockLocation;
  late LocationRepoImpl sut;

  setUp(() {
    mockLocation = MockLocation();
    sut = LocationRepoImpl(location: mockLocation);
  });

  group("getLocation", () {
    group("when there is no location rights", () {
      test('should throw a UtilException', () async {
        //arrange
        when(mockLocation.getLocation()).thenThrow(Error());
        //expect & assert
        expect(
          () => sut.getLocation(),
          throwsA(
            isA<UtilException>(),
          ),
        );
      });
    });

    group("when the rights are provided", () {
      final LocationData locationData =
          LocationData.fromMap({"latitude": 11.4562, "longitude": 45.512});
      test('should return a map with the latitude and longitude', () async {
        //arrange
        when(mockLocation.getLocation()).thenAnswer((_) async => locationData);
        //act
        final result = await sut.getLocation();
        //assert
        final expectedMap = {
          "latitude": locationData.latitude,
          "longitude": locationData.longitude
        };
        expect(result, expectedMap);
      });
    });
  });
}

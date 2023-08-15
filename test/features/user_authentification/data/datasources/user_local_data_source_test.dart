import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late UserLocalDataSourceImpl userLocalDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    userLocalDataSourceImpl =
        UserLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    "getLastCachedToken",
    () {
      const tToken =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkZWYyMGYwZC02OGY5LTQ5OTAtYjk4MC';
      test(
        "should get the last cached Token",
        () async {
          //assert
          when(mockSharedPreferences.getString(CACHED_JWT_TOKEN))
              .thenReturn(tToken);
          //act
          final result = await userLocalDataSourceImpl.getLastCachedToken();
          //arrange
          verify(mockSharedPreferences.getString(CACHED_JWT_TOKEN));
          expect(result, tToken);
        },
      );

      test(
        "should throw a cacheException if there is no token",
        () async {
          //assert
          when(mockSharedPreferences.getString(CACHED_JWT_TOKEN))
              .thenReturn(null);
          //act
          final call = userLocalDataSourceImpl.getLastCachedToken;
          //arrange
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    "getLastLoginDatetime",
    () {
      final tDatetime = DateTime.now().toString();
      test(
        "should throw a cacheException if there is no data",
        () async {
          //assert
          when(mockSharedPreferences.getString(CACHED_LOGIN_DATETIME))
              .thenReturn(null);
          //act
          final call = userLocalDataSourceImpl.getLastLoginDatetime;
          //arrange
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
      test(
        "should get the last cached Token",
        () async {
          //assert
          when(mockSharedPreferences.getString(CACHED_LOGIN_DATETIME))
              .thenReturn(tDatetime);
          //act
          final result = await userLocalDataSourceImpl.getLastLoginDatetime();
          //arrange
          verify(mockSharedPreferences.getString(CACHED_LOGIN_DATETIME));
          expect(result, DateTime.parse(tDatetime));
        },
      );
    },
  );

  group(
    "getLastPref",
    () {
      test(
        "should get the last cached connexion preference",
        () async {
          const tPref = true;

          //assert
          when(mockSharedPreferences.getBool(CACHED_CONNEXION_PREF))
              .thenReturn(tPref);
          //act
          final result = await userLocalDataSourceImpl.getLastPref();
          //arrange
          verify(mockSharedPreferences.getBool(CACHED_CONNEXION_PREF))
              .called(1);
          expect(result, tPref);
        },
      );

      test(
        "should throw a cacheException if there is data",
        () async {
          //assert
          when(mockSharedPreferences.getBool(CACHED_CONNEXION_PREF))
              .thenReturn(null);
          //act
          final call = userLocalDataSourceImpl.getLastPref;
          //arrange
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    "getUserAuth",
    () {
      test(
        "should get the user email and password if present",
        () async {
          final Map<String, String> tUserAuth = {
            "email": "test@gmail.com",
            "password": "123456"
          };
          //assert
          when(mockSharedPreferences.getString(CACHED_USER_AUTH_DATA))
              .thenReturn(fixture('user_auth.json'));
          //act
          final result = await userLocalDataSourceImpl.getUserAuth();
          //arrange

          expect(result, tUserAuth);
        },
      );

      test(
        "should throw a cacheException if there is no data present",
        () async {
          //assert
          when(mockSharedPreferences.getString(CACHED_USER_AUTH_DATA))
              .thenReturn(null);
          //act
          final call = userLocalDataSourceImpl.getUserAuth;
          //arrange
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    "storeConnexionData",
    () {
      group(
        "Store all the connexion Data ",
        () {
          const tPref = true;
          final Map<String, String> tUserAuth = {
            "email": "test@gmail.com",
            "password": "123456"
          };
          final tDateTime = DateTime.now().toString();
          const tToken =
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkZWYyMGYwZC02OGY5LTQ5OTAtYjk4MC';

          test(
            "should store the pref setting",
            () async {
              //assert
              when(mockSharedPreferences.setBool(any, any))
                  .thenAnswer((_) async => true);
              when(mockSharedPreferences.setString(CACHED_JWT_TOKEN, any))
                  .thenAnswer((_) async => true);
              when(mockSharedPreferences.setString(CACHED_LOGIN_DATETIME, any))
                  .thenAnswer((_) async => true);
              when(mockSharedPreferences.setString(CACHED_USER_AUTH_DATA, any))
                  .thenAnswer((_) async => true);
              //act
              await userLocalDataSourceImpl.storeConnexionData(
                  pref: tPref,
                  userAuth: tUserAuth,
                  dateTime: tDateTime,
                  jwtToken: tToken);
              //arrange
              verify(mockSharedPreferences.setBool(
                CACHED_CONNEXION_PREF,
                tPref,
              ));
              verify(mockSharedPreferences.setString(
                CACHED_JWT_TOKEN,
                tToken,
              ));
              verify(mockSharedPreferences.setString(
                CACHED_LOGIN_DATETIME,
                tDateTime,
              ));
              verify(mockSharedPreferences.setString(
                CACHED_USER_AUTH_DATA,
                json.encode(tUserAuth),
              ));
            },
          );
        },
      );
    },
  );
}

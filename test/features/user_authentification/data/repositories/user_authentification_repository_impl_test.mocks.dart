// Mocks generated by Mockito 5.4.2 from annotations
// in faro_clean_tdd/test/features/user_authentification/data/repositories/user_authentification_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:faro_clean_tdd/core/network/network_info.dart' as _i2;
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart'
    as _i6;
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart'
    as _i4;
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i2.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i4.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i5.UserModel?> userLogInRequest(
          {required Map<String, String>? logInInfo}) =>
      (super.noSuchMethod(
        Invocation.method(
          #userLogInRequest,
          [],
          {#logInInfo: logInInfo},
        ),
        returnValue: _i3.Future<_i5.UserModel?>.value(),
      ) as _i3.Future<_i5.UserModel?>);
  @override
  _i3.Future<_i5.UserModel?> userSignInRequest(
          {required Map<String, String>? signInInfo}) =>
      (super.noSuchMethod(
        Invocation.method(
          #userSignInRequest,
          [],
          {#signInInfo: signInInfo},
        ),
        returnValue: _i3.Future<_i5.UserModel?>.value(),
      ) as _i3.Future<_i5.UserModel?>);
}

/// A class which mocks [UserLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserLocalDataSource extends _i1.Mock
    implements _i6.UserLocalDataSource {
  MockUserLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool?> getLastPref() => (super.noSuchMethod(
        Invocation.method(
          #getLastPref,
          [],
        ),
        returnValue: _i3.Future<bool?>.value(),
      ) as _i3.Future<bool?>);
  @override
  _i3.Future<Map<String, dynamic>?> getUserAuth() => (super.noSuchMethod(
        Invocation.method(
          #getUserAuth,
          [],
        ),
        returnValue: _i3.Future<Map<String, dynamic>?>.value(),
      ) as _i3.Future<Map<String, dynamic>?>);
  @override
  _i3.Future<DateTime?> getLastLoginDatetime() => (super.noSuchMethod(
        Invocation.method(
          #getLastLoginDatetime,
          [],
        ),
        returnValue: _i3.Future<DateTime?>.value(),
      ) as _i3.Future<DateTime?>);
  @override
  _i3.Future<String?> getLastCachedToken() => (super.noSuchMethod(
        Invocation.method(
          #getLastCachedToken,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
  @override
  _i3.Future<void>? storeConnexionData({
    required bool? pref,
    required Map<String, String>? userAuth,
    required String? dateTime,
    required String? jwtToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeConnexionData,
          [],
          {
            #pref: pref,
            #userAuth: userAuth,
            #dateTime: dateTime,
            #jwtToken: jwtToken,
          },
        ),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>?);
}
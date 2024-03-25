// Mocks generated by Mockito 5.4.3 from annotations
// in faro_clean_tdd/test/features/user_authentification/domain/usecases/reset_password_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:faro_clean_tdd/core/errors/failures.dart' as _i5;
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart'
    as _i6;
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserAuthentificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserAuthentificationRepository extends _i1.Mock
    implements _i3.UserAuthentificationRepository {
  MockUserAuthentificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> logUserIn(
    String? email,
    String? password,
    bool? pref,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #logUserIn,
          [
            email,
            password,
            pref,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
            _FakeEither_0<_i5.Failure, _i6.User?>(
          this,
          Invocation.method(
            #logUserIn,
            [
              email,
              password,
              pref,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> signUserIn(
    String? email,
    String? password,
    String? username,
    String? phoneNumber,
    bool? pref,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUserIn,
          [
            email,
            password,
            username,
            phoneNumber,
            pref,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
            _FakeEither_0<_i5.Failure, _i6.User?>(
          this,
          Invocation.method(
            #signUserIn,
            [
              email,
              password,
              username,
              phoneNumber,
              pref,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);

  @override
  _i4.Future<Map<String, dynamic>?> getUserInfo() => (super.noSuchMethod(
        Invocation.method(
          #getUserInfo,
          [],
        ),
        returnValue: _i4.Future<Map<String, dynamic>?>.value(),
      ) as _i4.Future<Map<String, dynamic>?>);

  @override
  _i4.Future<_i5.Failure?> logUserOut({required String? jwt}) =>
      (super.noSuchMethod(
        Invocation.method(
          #logUserOut,
          [],
          {#jwt: jwt},
        ),
        returnValue: _i4.Future<_i5.Failure?>.value(),
      ) as _i4.Future<_i5.Failure?>);

  @override
  _i4.Future<_i6.User?> logInWithToken() => (super.noSuchMethod(
        Invocation.method(
          #logInWithToken,
          [],
        ),
        returnValue: _i4.Future<_i6.User?>.value(),
      ) as _i4.Future<_i6.User?>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> requestResetToken(
          {required String? email}) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestResetToken,
          [],
          {#email: email},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #requestResetToken,
            [],
            {#email: email},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> resetPassword({
    required String? email,
    required String? token,
    required String? newPassword,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [],
          {
            #email: email,
            #token: token,
            #newPassword: newPassword,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #resetPassword,
            [],
            {
              #email: email,
              #token: token,
              #newPassword: newPassword,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

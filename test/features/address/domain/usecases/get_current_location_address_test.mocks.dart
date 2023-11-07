// Mocks generated by Mockito 5.4.2 from annotations
// in faro_clean_tdd/test/features/address/domain/usecases/get_current_location_address_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:faro_clean_tdd/core/errors/failures.dart' as _i5;
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart'
    as _i6;
import 'package:faro_clean_tdd/features/address/domain/repositories/address_repository.dart'
    as _i2;
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

/// A class which mocks [AddressRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddressRepository extends _i1.Mock implements _i2.AddressRepository {
  MockAddressRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?>
      getCurrentLocationAddress() => (super.noSuchMethod(
            Invocation.method(
              #getCurrentLocationAddress,
              [],
            ),
            returnValue:
                _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?>.value(),
          ) as _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?>);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?> getSelectedLocationAddress(
    double? latitude,
    double? longitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSelectedLocationAddress,
          [
            latitude,
            longitude,
          ],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?>.value(),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.Address?>?>);
}

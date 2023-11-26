// Mocks generated by Mockito 5.4.2 from annotations
// in faro_clean_tdd/test/features/events/presentation/providers/update_event/update_event_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i9;

import 'package:dartz/dartz.dart' as _i5;
import 'package:faro_clean_tdd/core/errors/failures.dart' as _i6;
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart'
    as _i8;
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart'
    as _i7;
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart'
    as _i2;
import 'package:faro_clean_tdd/features/events/domain/usecases/update_an_event.dart'
    as _i3;
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

class _FakeEventRepository_0 extends _i1.SmartFake
    implements _i2.EventRepository {
  _FakeEventRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UpdateAnEventUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateAnEventUsecase extends _i1.Mock
    implements _i3.UpdateAnEventUsecase {
  MockUpdateAnEventUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.EventRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeEventRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.EventRepository);
  @override
  _i4.Future<_i5.Either<_i6.Failure, _i7.Event>?> execute({
    required _i8.EventModel? event,
    required _i9.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {
            #event: event,
            #image: image,
          },
        ),
        returnValue: _i4.Future<_i5.Either<_i6.Failure, _i7.Event>?>.value(),
      ) as _i4.Future<_i5.Either<_i6.Failure, _i7.Event>?>);
}

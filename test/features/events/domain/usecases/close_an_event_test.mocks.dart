// Mocks generated by Mockito 5.4.4 from annotations
// in faro_clean_tdd/test/features/events/domain/usecases/close_an_event_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Dart imports:
import 'dart:async' as _i4;
import 'dart:io' as _i8;

// Package imports:
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// Project imports:
import 'package:faro_faro/core/errors/failures.dart' as _i5;
import 'package:faro_faro/features/events/data/models/event_model.dart' as _i7;
import 'package:faro_faro/features/events/domain/entities/event.dart' as _i6;

import 'package:faro_faro/features/events/domain/repositories/event_repository.dart'
    as _i3;

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

/// A class which mocks [EventRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventRepository extends _i1.Mock implements _i3.EventRepository {
  MockEventRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Event>>> fetchAllEvents() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAllEvents,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Event>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Event>>(
          this,
          Invocation.method(
            #fetchAllEvents,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Event>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Event>> postAnEvent({
    required _i7.EventModel? event,
    required _i8.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postAnEvent,
          [],
          {
            #event: event,
            #image: image,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>.value(
            _FakeEither_0<_i5.Failure, _i6.Event>(
          this,
          Invocation.method(
            #postAnEvent,
            [],
            {
              #event: event,
              #image: image,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Event>> updateAnEvent({
    required _i7.EventModel? event,
    required _i8.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateAnEvent,
          [],
          {
            #event: event,
            #image: image,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>.value(
            _FakeEither_0<_i5.Failure, _i6.Event>(
          this,
          Invocation.method(
            #updateAnEvent,
            [],
            {
              #event: event,
              #image: image,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Event>> activateAnEvent(
          {required int? eventId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #activateAnEvent,
          [],
          {#eventId: eventId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>.value(
            _FakeEither_0<_i5.Failure, _i6.Event>(
          this,
          Invocation.method(
            #activateAnEvent,
            [],
            {#eventId: eventId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Event>> closeAnEvent(
          {required int? eventId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #closeAnEvent,
          [],
          {#eventId: eventId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>.value(
            _FakeEither_0<_i5.Failure, _i6.Event>(
          this,
          Invocation.method(
            #closeAnEvent,
            [],
            {#eventId: eventId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Event>>);
}

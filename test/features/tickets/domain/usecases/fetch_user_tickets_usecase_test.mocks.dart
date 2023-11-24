// Mocks generated by Mockito 5.4.2 from annotations
// in faro_clean_tdd/test/features/tickets/domain/usecases/fetch_user_tickets_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:faro_clean_tdd/core/errors/failures.dart' as _i5;
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart'
    as _i6;
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart'
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

/// A class which mocks [TicketRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTicketRepository extends _i1.Mock implements _i2.TicketRepository {
  MockTicketRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.Ticket>>? createTicket(
          {required _i6.Ticket? ticket}) =>
      (super.noSuchMethod(Invocation.method(
        #createTicket,
        [],
        {#ticket: ticket},
      )) as _i3.Future<_i4.Either<_i5.Failure, _i6.Ticket>>?);
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.Ticket>>? updateTicket({
    required int? userId,
    required _i6.Ticket? updatedTicket,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #updateTicket,
        [],
        {
          #userId: userId,
          #updatedTicket: updatedTicket,
        },
      )) as _i3.Future<_i4.Either<_i5.Failure, _i6.Ticket>>?);
  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.Ticket>>>? fetchUserTickets(
          {required int? userId}) =>
      (super.noSuchMethod(Invocation.method(
        #fetchUserTickets,
        [],
        {#userId: userId},
      )) as _i3.Future<_i4.Either<_i5.Failure, List<_i6.Ticket>>>?);
}

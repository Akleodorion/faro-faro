// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:faro_faro/features/members/domain/entities/member.dart';

class FetchMembersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends FetchMembersState {}

class Loading extends FetchMembersState {}

class Loaded extends FetchMembersState {
  Loaded({required this.members, required this.message});
  final List<Member> members;
  final String message;

  Loaded copyWith({List<Member>? members, String? message}) {
    return Loaded(
        members: members ?? this.members, message: message ?? this.message);
  }
}

class Error extends FetchMembersState {
  Error({required this.message});
  final String message;
}

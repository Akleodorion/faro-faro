// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:faro_faro/features/members/data/models/member_model.dart';

class CreateMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CreateMemberState {}

class Loading extends CreateMemberState {}

class Loaded extends CreateMemberState {
  Loaded({required this.member, required this.message});

  final MemberModel member;
  final String message;
}

class Error extends CreateMemberState {
  Error({required this.message});
  final String message;
}

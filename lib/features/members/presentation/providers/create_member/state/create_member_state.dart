import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

class CreateMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CreateMemberState {}

class Loading extends CreateMemberState {}

class Loaded extends CreateMemberState {
  Loaded({required this.member});

  final Member member;
}

class Error extends CreateMemberState {
  Error({required this.message});
  final String message;
}

// Package imports:
import 'package:equatable/equatable.dart';

class DeleteMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends DeleteMemberState {
  Initial({this.message});
  final String? message;
}

class Loading extends DeleteMemberState {}

class Error extends DeleteMemberState {
  Error({required this.message});
  final String message;
}

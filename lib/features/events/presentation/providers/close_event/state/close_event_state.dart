// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../domain/entities/event.dart';

abstract class CloseEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CloseEventState {}

class Loading extends CloseEventState {}

class Loaded extends CloseEventState {
  Loaded({required this.event, required this.message});

  // List of events
  final Event event;
  final String message;
}

class Error extends CloseEventState {
  Error({
    required this.message,
  });

  // Message
  final String message;
}

import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class PostEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends PostEventState {
  Initial({required this.isFree});

  final bool isFree;
}

class Loading extends PostEventState {}

class Loaded extends PostEventState {
  Loaded({
    required this.event,
  });

  // List of events
  final Event event;
}

class Error extends PostEventState {
  Error({
    required this.message,
  });

  // List of events

  // Message
  final String message;
}

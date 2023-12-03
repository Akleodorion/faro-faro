import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class ActivateEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends ActivateEventState {}

class Loading extends ActivateEventState {}

class Loaded extends ActivateEventState {
  Loaded({required this.event});

  // List of events
  final Event event;
}

class Error extends ActivateEventState {
  Error({
    required this.message,
  });

  // Message
  final String message;
}

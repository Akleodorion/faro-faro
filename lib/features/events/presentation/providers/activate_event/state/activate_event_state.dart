import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class ActivateEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends ActivateEventState {}

class Loading extends ActivateEventState {}

class Loaded extends ActivateEventState {
  Loaded({required this.event, required this.message});

  // List of events
  final Event event;
  final String message;
}

class Error extends ActivateEventState {
  Error({
    required this.message,
  });

  // Message
  final String message;
}

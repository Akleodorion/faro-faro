import 'package:equatable/equatable.dart';
import '../../../domain/entities/event.dart';

abstract class EventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends EventState {}

class Loaded extends EventState {
  Loaded({
    required this.indexEvent,
    required this.randomEvents,
    required this.upcomingEvents,
  });

  // List of events
  final List<Event> indexEvent;
  final List<Event> randomEvents;
  final List<Event> upcomingEvents;
}

class Error extends EventState {
  Error({
    required this.indexEvent,
    required this.message,
  });

  // List of events
  final List<Event> indexEvent;

  // Message
  final String message;
}

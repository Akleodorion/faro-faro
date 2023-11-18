import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class FetchEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends FetchEventState {}

class Loaded extends FetchEventState {
  Loaded({
    required this.indexEvent,
    required this.allEvents,
  });

  // List of events
  final List<Event> indexEvent;
  final List<Event> allEvents;
}

class Error extends FetchEventState {
  Error({
    required this.indexEvent,
    required this.message,
  });

  // List of events
  final List<Event> indexEvent;

  // Message
  final String message;
}

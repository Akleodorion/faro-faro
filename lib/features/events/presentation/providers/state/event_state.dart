import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';

abstract class EventState extends Equatable {
  @override
  List<Object?> get props => [];
}



class Loading extends EventState {}

class Loaded extends EventState {
  Loaded({
    required this.indexEvent,
  });

  // Index Events
  final List<Event> indexEvent;
}

class Error extends EventState {
  Error({
    required this.indexEvent,
    required this.message,
  });

  // Index Events
  final List<Event> indexEvent;

  // Message
  final String message;
}

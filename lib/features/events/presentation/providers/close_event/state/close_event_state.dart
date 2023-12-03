import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class CloseEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CloseEventState {}

class Loading extends CloseEventState {}

class Loaded extends CloseEventState {
  Loaded({required this.event});

  // List of events
  final Event event;
}

class Error extends CloseEventState {
  Error({
    required this.message,
  });

  // Message
  final String message;
}

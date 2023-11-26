import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class UpdateEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends UpdateEventState {
  Initial({required this.infoMap});
  final Map<String, dynamic> infoMap;

  Initial copyWith(
      {Map<String, dynamic>? infoMap /*, autres propriétés ici...*/}) {
    return Initial(
      infoMap: infoMap ?? this.infoMap,
      // Copiez d'autres propriétés ici...
    );
  }
}

class Loading extends UpdateEventState {}

class Loaded extends UpdateEventState {
  Loaded({
    required this.event,
  });

  // List of events
  final Event event;
}

class Error extends UpdateEventState {
  Error({
    required this.message,
    required this.infoMap,
  });

  // List of events

  // Message
  final String message;
  final Map<String, dynamic> infoMap;
}

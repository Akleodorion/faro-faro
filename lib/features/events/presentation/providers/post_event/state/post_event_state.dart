import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class PostEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends PostEventState {
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
    required this.infoMap,
  });

  // List of events

  // Message
  final String message;
  final Map<String, dynamic> infoMap;
}

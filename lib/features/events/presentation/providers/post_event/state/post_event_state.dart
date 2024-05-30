// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
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
    required this.message,
  });

  final Event event;
  final String message;
}

class Error extends PostEventState {
  Error({
    required this.message,
  });

  final String message;
}

import 'package:equatable/equatable.dart';
import '../../../../domain/entities/event.dart';

abstract class UpdateEventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends UpdateEventState {
  Initial({required this.infoMap});
  final Map<String, dynamic> infoMap;

  Initial copyWith({Map<String, dynamic>? infoMap}) {
    return Initial(
      infoMap: infoMap ?? this.infoMap,
    );
  }
}

class Loading extends UpdateEventState {}

class Loaded extends UpdateEventState {
  Loaded({
    required this.event,
    required this.message,
  });

  final Event event;
  final String message;
}

class Error extends UpdateEventState {
  Error({
    required this.message,
    required this.infoMap,
  });

  final String message;
  final Map<String, dynamic> infoMap;
}

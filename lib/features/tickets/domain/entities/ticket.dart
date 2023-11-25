import 'package:equatable/equatable.dart';

enum Type { standard, gold, platinum, unknown }

class Ticket extends Equatable {
  final int id;
  final Type type;
  final String description;
  final int? price;
  final int userId;
  final int eventId;
  final bool verified;

  const Ticket({
    required this.id,
    required this.type,
    required this.description,
    this.price, // can be null if event is free
    required this.eventId,
    required this.userId,
    required this.verified,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        description,
        price,
        eventId,
        userId,
        verified,
      ];
}

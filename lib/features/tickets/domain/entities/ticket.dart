import 'package:equatable/equatable.dart';

enum Type { standard, gold, platinum, unknown }

class Ticket extends Equatable {
  final int? id;
  final Type type;
  final String description;
  final int? price;
  final int userId;
  final int eventId;
  final String qrCodeUrl;
  final bool verified;

  const Ticket({
    required this.id,
    required this.type,
    required this.description,
    this.price,
    required this.eventId,
    required this.userId,
    required this.qrCodeUrl,
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

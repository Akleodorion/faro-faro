import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.type,
    required super.description,
    super.price,
    required super.eventId,
    required super.userId,
    required super.verified,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    final typeMap = {
      "standard": Type.standard,
      "gold": Type.gold,
      "platinum": Type.platinum
    };

    return TicketModel(
        id: json["id"],
        type: typeMap[json["type"]] ?? Type.unknown,
        description: json["description"],
        eventId: json["event_id"],
        userId: json["user_id"],
        price: json["price"],
        verified: json["verified"]);
  }

  toJson() {
    return {
      "id": id,
      "type": type.name,
      "description": description,
      "event_id": eventId,
      "user_id": userId,
      "verified": verified,
    };
  }
}

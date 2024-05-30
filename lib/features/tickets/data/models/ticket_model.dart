// Project imports:
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.type,
    required super.description,
    super.price,
    required super.eventId,
    required super.userId,
    required super.qrCodeUrl,
    required super.verified,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json["id"],
        type: getTicketTypeFromJson(json),
        description: json["description"],
        eventId: json["event_id"],
        userId: json["user_id"],
        price: json["price"],
        qrCodeUrl: json["qr_code_url"],
        verified: json["verified"]);
  }

  toJson() {
    return {
      "id": id,
      "type": type.name,
      "description": description,
      "event_id": eventId,
      "user_id": userId,
      "qr_code_url": qrCodeUrl,
      "verified": verified,
    };
  }
}

Type getTicketTypeFromJson(json) {
  final typeMap = {
    "standard": Type.standard,
    "gold": Type.gold,
    "platinum": Type.platinum
  };

  return typeMap[json["type"]] ?? Type.unknown;
}

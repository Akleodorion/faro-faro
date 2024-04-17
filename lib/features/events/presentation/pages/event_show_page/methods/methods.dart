import '../../../../../tickets/domain/entities/ticket.dart';

Map<String, dynamic> getTicketInfo({required String qrcode}) {
  final List splitted = qrcode.split(',');

  return {
    "ticketId": int.parse(splitted[0]),
    "eventId": int.parse(splitted[1]),
    "ticketType": setTicketType(type: splitted[2])
  };
}

Type setTicketType({required String type}) {
  final typeMap = {
    "standard": Type.standard,
    "gold": Type.gold,
    "platinum": Type.platinum
  };

  return typeMap[type] ?? Type.unknown;
}

bool isATicketOfEvent({
  required List<Ticket> tickets,
  required int ticketId,
  required Type type,
}) {
  try {
    tickets.firstWhere(
        (element) => element.id == ticketId && element.type == type);
    return true;
  } on StateError {
    return false;
  }
}

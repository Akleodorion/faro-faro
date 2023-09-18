import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.name,
    required super.description,
    required super.date,
    required super.location,
    required super.category,
    required super.imageUrl,
    required super.userId,
    required super.modelEco,
    required super.eventId,
    required super.standardTicketPrice,
    required super.maxStandardTicket,
    required super.vipTicketPrice,
    required super.maxVipTicket,
    required super.vvipTicketPrice,
    required super.maxVvipTicket,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    late Category category;
    late ModelEco modelEco;

    if (json["free"] == true) {
      modelEco = ModelEco.gratuit;
    } else {
      modelEco = ModelEco.payant;
    }

    if (json["category"] == "losir") {
      category = Category.loisir;
    } else if (json["category"] == "culture") {
      category = Category.culture;
    } else if (json["category"] == "sport") {
      category = Category.sport;
    } else {
      category = Category.concert;
    }

    return EventModel(
      name: json["name"],
      description: json["description"],
      date: DateTime.tryParse(json["date"])!,
      location: json["location"],
      category: category,
      imageUrl: json["photo_url"],
      userId: json["user_id"],
      modelEco: modelEco,
      eventId: json["id"],
      maxStandardTicket: json["max_standard_ticket"],
      standardTicketPrice: json["standard_ticket_price"],
      maxVipTicket: json["max_vip_ticket"],
      vipTicketPrice: json["vip_ticket_price"],
      maxVvipTicket: json["max_vvip_ticket"],
      vvipTicketPrice: json["vvip_ticket_price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'category': category.name,
      'photo_url': imageUrl,
      'user_id': userId,
      'free': modelEco == ModelEco.gratuit ? true : false,
      'id': eventId,
      'max_standard_ticket': maxStandardTicket,
      'standard_ticket_price': standardTicketPrice,
      'max_vip_ticket': maxVipTicket,
      'vip_ticket_price': vipTicketPrice,
      'max_vvip_ticket': maxVvipTicket,
      'vvip_ticket_price': vvipTicketPrice,
    };
  }
}

import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel(
      {required super.name,
      required super.eventId,
      required super.description,
      required super.date,
      required super.address,
      required super.category,
      required super.imageUrl,
      required super.userId,
      required super.modelEco,
      required super.members,
      required super.standardTicketPrice,
      required super.maxStandardTicket,
      required super.standardTicketDescription,
      required super.goldTicketPrice,
      required super.maxGoldTicket,
      required super.goldTicketDescription,
      required super.platinumTicketDescription,
      required super.platinumTicketPrice,
      required super.maxPlatinumTicket,
      required super.activated,
      required super.tickets});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    late Category category;

    String getGeocoderUrl(
        {required double latitude, required double longitude}) {
      return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&key=${dotenv.env['API_KEY']}";
    }

    final Map<String, Category> categoryMap = {
      "loisir": Category.loisir,
      "culture": Category.culture,
      "sport": Category.sport,
      "concert": Category.concert,
    };

    final Map<String, Type> typeMap = {
      "standard": Type.standard,
      "gold": Type.gold,
      "platinum": Type.platinum,
    };

    category = categoryMap[json["category"]] ?? Category.concert;

    final List<Member> members = (json["members"] as List<dynamic>?)
            ?.map((element) => Member(
                  id: element["id"] ?? 0,
                  userId: element["user_id"] ?? 0,
                  eventId: element["event_id"] ?? 0,
                ))
            .toList() ??
        [];

    final List<Ticket> tickets = (json["tickets"] as List<dynamic>?)
            ?.map(
              (element) => Ticket(
                  id: element["id"],
                  type: typeMap[element["type"]] ?? Type.unknown,
                  description: element["description"],
                  price: element["price"],
                  eventId: element["event_id"],
                  userId: element["user_id"],
                  verified: element["verified"]),
            )
            .toList() ??
        [];

    return EventModel(
        name: json["name"],
        description: json["description"],
        date: DateTime.tryParse(json["date"])!,
        address: Address(
            latitude: json["latitude"],
            longitude: json["longitude"],
            addressName: json["location"],
            geocodeUrl: getGeocoderUrl(
                latitude: json["latitude"], longitude: json["longitude"])),
        category: category,
        imageUrl: json["photo_url"],
        userId: json["user_id"],
        modelEco: json["free"] == true ? ModelEco.gratuit : ModelEco.payant,
        members: members,
        tickets: tickets, //!
        eventId: json["id"],
        activated: json["activated"],
        maxStandardTicket: json["max_standard_ticket"],
        standardTicketPrice: json["standard_ticket_price"],
        standardTicketDescription: json["standard_ticket_description"],
        maxGoldTicket: json["max_gold_ticket"],
        goldTicketPrice: json["gold_ticket_price"],
        goldTicketDescription: json["gold_ticket_description"],
        maxPlatinumTicket: json["max_platinum_ticket"],
        platinumTicketPrice: json["platinum_ticket_price"],
        platinumTicketDescription: json["platinum_ticket_description"]);
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> membersList = [];
    final List<Map<String, dynamic>> ticketsList = [];

    for (var member in members) {
      membersList.add({
        "id": member.id,
        "user_id": member.userId,
        "event_id": member.eventId
      });
    }

    for (final ticket in tickets) {
      ticketsList.add({
        "id": ticket.id,
        "type": ticket.type.name,
        "description": ticket.description,
        "price": ticket.price,
        "verified": ticket.verified,
        "user_id": ticket.userId,
        "event_id": ticket.eventId,
      });
    }

    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': address.addressName,
      'latitude': address.latitude,
      'longitude': address.longitude,
      'category': category.name,
      'photo_url': imageUrl,
      'user_id': userId,
      'free': modelEco == ModelEco.gratuit ? true : false,
      'id': eventId,
      "members": membersList,
      "tickets": ticketsList,
      'max_standard_ticket': maxStandardTicket,
      'standard_ticket_price': standardTicketPrice,
      'standard_ticket_description': standardTicketDescription,
      'max_gold_ticket': maxGoldTicket,
      'gold_ticket_price': goldTicketPrice,
      'gold_ticket_description': goldTicketDescription,
      'max_platinum_ticket': maxPlatinumTicket,
      'platinum_ticket_price': platinumTicketPrice,
      'platinum_ticket_description': platinumTicketDescription,
    };
  }

  EventModel getEventModel(
      {required Map<String, dynamic> postEventMap, required int userId}) {
    final myEventModel = EventModel(
        name: postEventMap["name"],
        eventId: 0,
        description: postEventMap["description"],
        date: postEventMap["date"],
        address: Address(
            latitude: postEventMap["latitude"],
            longitude: postEventMap["longitude"],
            addressName: postEventMap["address"],
            geocodeUrl: postEventMap["geocodeUrl"]),
        category: postEventMap["category"],
        imageUrl: '',
        userId: userId,
        modelEco: postEventMap["modelEco"],
        members: const [],
        tickets: const [],
        activated: false,
        standardTicketPrice: postEventMap["standardTicketPrice"],
        maxStandardTicket: postEventMap["maxStandardTicket"],
        standardTicketDescription: postEventMap["standardTicketDescription"],
        goldTicketPrice: postEventMap["vipTicketPrice"],
        maxGoldTicket: postEventMap["maxVipTicket"],
        goldTicketDescription: postEventMap["vipTicketDescription"],
        platinumTicketPrice: postEventMap["vvipTicketPrice"],
        maxPlatinumTicket: postEventMap["maxVvipTicket"],
        platinumTicketDescription: postEventMap["vvipTicketDescription"]);

    return myEventModel;
  }
}

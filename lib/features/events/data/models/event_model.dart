import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
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
      required super.vipTicketPrice,
      required super.maxVipTicket,
      required super.vipTicketDescription,
      required super.vvipTicketPrice,
      required super.maxVvipTicket,
      required super.vvipTicketDescription,
      required super.activated});

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

    category = categoryMap[json["category"]] ?? Category.concert;

    final List<Member> members = (json["members"] as List<dynamic>?)
            ?.map((element) => Member(
                  id: element["id"] ?? 0,
                  userId: element["user_id"] ?? 0,
                  eventId: element["event_id"] ?? 0,
                ))
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
        eventId: json["id"],
        activated: json["activated"],
        maxStandardTicket: json["max_standard_ticket"],
        standardTicketPrice: json["standard_ticket_price"],
        standardTicketDescription: json["standard_ticket_description"],
        maxVipTicket: json["max_vip_ticket"],
        vipTicketPrice: json["vip_ticket_price"],
        vipTicketDescription: json["vip_ticket_description"],
        maxVvipTicket: json["max_vvip_ticket"],
        vvipTicketPrice: json["vvip_ticket_price"],
        vvipTicketDescription: json["vvip_ticket_description"]);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> membersListe = [];

    for (var member in members) {
      membersListe.add({
        "id": member.id,
        "user_id": member.userId,
        "event_id": member.eventId
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
      "members": membersListe,
      'max_standard_ticket': maxStandardTicket,
      'standard_ticket_price': standardTicketPrice,
      'standard_ticket_description': standardTicketDescription,
      'max_vip_ticket': maxVipTicket,
      'vip_ticket_price': vipTicketPrice,
      'vip_ticket_description': vipTicketDescription,
      'max_vvip_ticket': maxVvipTicket,
      'vvip_ticket_price': vvipTicketPrice,
      'vvip_ticket_description': vvipTicketDescription,
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
        members: postEventMap["members"],
        activated: false,
        standardTicketPrice: postEventMap["standardTicketPrice"],
        maxStandardTicket: postEventMap["maxStandardTicket"],
        standardTicketDescription: postEventMap["standardTicketDescription"],
        vipTicketPrice: postEventMap["vipTicketPrice"],
        maxVipTicket: postEventMap["maxVipTicket"],
        vipTicketDescription: postEventMap["vipTicketDescription"],
        vvipTicketPrice: postEventMap["vvipTicketPrice"],
        maxVvipTicket: postEventMap["maxVvipTicket"],
        vvipTicketDescription: postEventMap["vvipTicketDescription"]);

    return myEventModel;
  }
}

import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
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
      required super.standardTicketPrice,
      required super.maxStandardTicket,
      required super.standardTicketDescription,
      required super.vipTicketPrice,
      required super.maxVipTicket,
      required super.vipTicketDescription,
      required super.vvipTicketPrice,
      required super.maxVvipTicket,
      required super.vvipTicketDescription});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    late Category category;
    late ModelEco modelEco;

    if (json["free"] == true) {
      modelEco = ModelEco.gratuit;
    } else {
      modelEco = ModelEco.payant;
    }

    final geocodeUrl =
        "https://maps.googleapis.com/maps/api/staticmap?center=${json["latitude"]},${json["longitude"]}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${json["latitude"]},${json["longitude"]}&key=${dotenv.env['API_KEY']}";

    if (json["category"] == "loisir") {
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
        address: Address(
            latitude: json["latitude"],
            longitude: json["longitude"],
            addressName: json["location"],
            geocodeUrl: geocodeUrl),
        category: category,
        imageUrl: json["photo_url"],
        userId: json["user_id"],
        modelEco: modelEco,
        eventId: json["id"],
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

  Map<String, dynamic> toJsonCreate() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': address,
      'latitude': address.latitude,
      'longitude': address.longitude,
      'category': category.name,
      'user_id': userId,
      'free': modelEco == ModelEco.gratuit ? true : false,
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

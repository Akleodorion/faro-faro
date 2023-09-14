import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';

class EventModel extends Event {
  const EventModel(
      {required super.name,
      required super.description,
      required super.date,
      required super.location,
      required super.category,
      required super.imageUrl,
      required super.userId,
      required super.modelEco,
      required super.eventId});

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
      imageUrl: "imageUrl",
      userId: json["user_id"],
      modelEco: modelEco,
      eventId: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'category': category.name,
      'image_url': imageUrl,
      'user_id': userId,
      'free': modelEco == ModelEco.gratuit ? true : false,
      "id": eventId,
    };
  }
}

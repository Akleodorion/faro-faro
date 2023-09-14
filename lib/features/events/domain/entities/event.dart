import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

var formated = DateFormat.yMMMd('fr');

enum Category {
  loisir,
  concert,
  sport,
  culture,
}

enum ModelEco {
  gratuit,
  payant,
}

class Event extends Equatable {
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final Category category;
  final String imageUrl;
  final int userId;
  final int eventId;
  final ModelEco modelEco;

  const Event({
    required this.name,
    required this.eventId,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.userId,
    required this.modelEco,
  });

  String get formatedDate {
    return formated.format(date);
  }

  @override
  List<Object?> get props =>
      [name, description, date, location, category, imageUrl, userId, modelEco];
}

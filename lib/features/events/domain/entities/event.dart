import 'package:equatable/equatable.dart';

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
  final ModelEco modelEco;

  const Event({
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.userId,
    required this.modelEco,
  });

  @override
  List<Object?> get props =>
      [name, description, date, location, category, imageUrl, userId, modelEco];
}

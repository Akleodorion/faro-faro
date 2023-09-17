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
  final int standardTicketPrice;
  final int maxStandardTicket;
  final int vipTicketPrice;
  final int maxVipTicket;
  final int vvipTicketPrice;
  final int maxVvipTicket;

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
    required this.standardTicketPrice,
    required this.maxStandardTicket,
    required this.vipTicketPrice,
    required this.maxVipTicket,
    required this.vvipTicketPrice,
    required this.maxVvipTicket,
  });

  String get formatedDate {
    return formated.format(date);
  }

  @override
  List<Object?> get props => [
        name,
        description,
        date,
        location,
        category,
        imageUrl,
        userId,
        modelEco,
        standardTicketPrice,
        maxStandardTicket,
        vipTicketPrice,
        maxVipTicket,
        vvipTicketPrice,
        maxVvipTicket,
      ];
}

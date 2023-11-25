import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:intl/intl.dart';

var formated = DateFormat.yMMMd('fr');

enum ModelEco {
  gratuit,
  payant,
}

enum Category {
  concert,
  loisir,
  sport,
  culture,
  unknown,
}

class Event extends Equatable {
  final String name;
  final String description;
  final DateTime date;
  final Address address;
  final Category category;
  final String imageUrl;
  final int userId;
  final int eventId;
  final ModelEco modelEco;
  final List<Member> members;
  final List<Ticket> tickets;
  final bool activated;
  final int? standardTicketPrice;
  final int maxStandardTicket;
  final String standardTicketDescription;
  final int? goldTicketPrice;
  final int? maxGoldTicket;
  final String? goldTicketDescription;
  final int? platinumTicketPrice;
  final int? maxPlatinumTicket;
  final String? platinumTicketDescription;

  const Event(
      {required this.name,
      required this.eventId,
      required this.description,
      required this.date,
      required this.address,
      required this.category,
      required this.imageUrl,
      required this.userId,
      required this.modelEco,
      required this.members,
      required this.tickets,
      required this.activated,
      this.standardTicketPrice,
      required this.maxStandardTicket,
      required this.standardTicketDescription,
      this.goldTicketPrice,
      this.maxGoldTicket,
      this.goldTicketDescription,
      this.platinumTicketPrice,
      this.maxPlatinumTicket,
      this.platinumTicketDescription});

  String get formatedDate {
    return formated.format(date);
  }

  @override
  List<Object?> get props => [
        name,
        description,
        date,
        address,
        category,
        imageUrl,
        userId,
        modelEco,
        members,
        standardTicketPrice,
        maxStandardTicket,
        standardTicketDescription,
        goldTicketPrice,
        maxGoldTicket,
        goldTicketDescription,
        platinumTicketPrice,
        maxPlatinumTicket,
        platinumTicketDescription,
      ];
}

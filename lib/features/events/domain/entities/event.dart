import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
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
  final int standardTicketPrice;
  final int maxStandardTicket;
  final String standardTicketDescription;
  final int vipTicketPrice;
  final int maxVipTicket;
  final String vipTicketDescription;
  final int vvipTicketPrice;
  final int maxVvipTicket;
  final String vvipTicketDescription;

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
      required this.standardTicketPrice,
      required this.maxStandardTicket,
      required this.standardTicketDescription,
      required this.vipTicketPrice,
      required this.maxVipTicket,
      required this.vipTicketDescription,
      required this.vvipTicketPrice,
      required this.maxVvipTicket,
      required this.vvipTicketDescription});

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
        vipTicketPrice,
        maxVipTicket,
        vipTicketDescription,
        vvipTicketPrice,
        maxVvipTicket,
        vvipTicketDescription,
      ];
}

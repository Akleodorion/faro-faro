// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:faro_faro/core/util/try_parse_time_of_day.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';

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
  final int? id;

  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Address address;
  final Category category;
  final String imageUrl;
  final int userId;
  final ModelEco modelEco;
  final List<MemberModel> members;
  final List<TicketModel> tickets;
  final bool activated;
  final bool closed;
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
      required this.id,
      required this.description,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.category,
      required this.imageUrl,
      required this.userId,
      required this.modelEco,
      required this.members,
      required this.tickets,
      required this.activated,
      required this.closed,
      this.standardTicketPrice,
      required this.maxStandardTicket,
      required this.standardTicketDescription,
      this.goldTicketPrice,
      this.maxGoldTicket,
      this.goldTicketDescription,
      this.platinumTicketPrice,
      this.maxPlatinumTicket,
      this.platinumTicketDescription});

  Event copyWith({List<MemberModel>? members, bool? activated, bool? closed}) {
    return Event(
      name: name,
      id: id,
      description: description,
      date: date,
      startTime: startTime,
      endTime: endTime,
      address: address,
      category: category,
      imageUrl: imageUrl,
      userId: userId,
      modelEco: modelEco,
      members: members ?? this.members,
      tickets: tickets,
      activated: activated ?? this.activated,
      closed: closed ?? this.closed,
      maxStandardTicket: maxStandardTicket,
      standardTicketDescription: standardTicketDescription,
      goldTicketDescription: goldTicketDescription,
      goldTicketPrice: goldTicketPrice,
      maxGoldTicket: maxGoldTicket,
      standardTicketPrice: standardTicketPrice,
      platinumTicketPrice: platinumTicketPrice,
      platinumTicketDescription: platinumTicketDescription,
      maxPlatinumTicket: maxPlatinumTicket,
    );
  }

  String get formatedDate {
    return formated.format(date);
  }

  int get standardTicketNumber {
    final myList =
        tickets.where((ticket) => ticket.type == Type.standard).toList();
    return myList.length;
  }

  String get standardTicketLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.standard);
    final ticketCount = maxStandardTicket - myList.length;

    if (ticketCount == 0) {
      return "Il n'y a plus de ticket standard disponible";
    } else if (ticketCount == 1) {
      return "$ticketCount ticket restant";
    } else {
      return '$ticketCount tickets restants';
    }
  }

  int get standardTicketCountLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.standard);
    final ticketCount = maxStandardTicket - myList.length;

    return ticketCount;
  }

  int get goldTicketNumber {
    final myList = tickets.where((ticket) => ticket.type == Type.gold).toList();
    return myList.length;
  }

  String get goldTicketLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.gold);

    if (maxGoldTicket == null) {
      return "Il n'y a pas de ticket de ce type en vente.";
    } else {
      final ticketCount = maxGoldTicket! - myList.length;
      if (ticketCount == 0) {
        return "Il n'y a plus de ticket gold disponible";
      } else if (ticketCount == 1) {
        return "$ticketCount ticket restant";
      } else {
        return '$ticketCount tickets restants';
      }
    }
  }

  int? get goldTicketCountLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.gold);
    if (maxGoldTicket != null) {
      final ticketCount = maxGoldTicket! - myList.length;
      return ticketCount;
    }

    return null;
  }

  int get platinumTicketNumber {
    final myList =
        tickets.where((ticket) => ticket.type == Type.platinum).toList();
    return myList.length;
  }

  String get platinumTicketLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.platinum);

    if (maxPlatinumTicket == null) {
      return "Il n'y a pas de ticket de ce type en vente.";
    } else {
      final ticketCount = maxPlatinumTicket! - myList.length;
      if (ticketCount == 0) {
        return "plus de ticket disponible";
      } else if (ticketCount == 1) {
        return "$ticketCount ticket restants";
      } else {
        return '$ticketCount tickets restants';
      }
    }
  }

  int? get platinumTicketCountLeft {
    final myList = tickets.where((ticket) => ticket.type == Type.platinum);
    if (maxPlatinumTicket != null) {
      final ticketCount = maxPlatinumTicket! - myList.length;
      return ticketCount;
    }

    return null;
  }

  int get amountSold {
    int sum = 0;
    for (final ticket in tickets) {
      ticket.price != null ? sum += ticket.price! : null;
    }
    return sum;
  }

  bool get isFree {
    return modelEco == ModelEco.gratuit;
  }

  String get eventTimeFrame {
    return "${DateFormat('dd/MM/yyyy').format(date)}: ${TryParseTimeOfDayImpl().getString(timeToParse: startTime)}  - ${TryParseTimeOfDayImpl().getString(timeToParse: endTime)}";
  }

  TicketModel retrieveTicketWithId({required int ticketId}) {
    return tickets.firstWhere((element) => element.id == ticketId);
  }

  @override
  List<Object?> get props => [
        name,
        description,
        date,
        startTime,
        endTime,
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

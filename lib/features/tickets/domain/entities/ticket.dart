import 'package:equatable/equatable.dart';

enum Type {
  standard,
  gold,
  platinum,
}

class Ticket extends Equatable {
  final Type type;
  final String description;
  final int? price;
  final int userId;
  final bool verfied;

  const Ticket({
    required this.type,
    required this.description,
    this.price, // can be null if event is free
    required this.userId,
    required this.verfied,
  });

  @override
  List<Object?> get props => [
        type,
        description,
        price,
        userId,
        verfied,
      ];
}

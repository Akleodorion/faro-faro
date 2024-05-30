// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

@immutable
class Member extends Equatable {
  const Member(
      {required this.id,
      required this.username,
      required this.userId,
      required this.eventId});

  final int? id;
  final int userId;
  final String username;
  final int eventId;

  //Equatable
  @override
  List<Object?> get props => [id, userId, eventId, username];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Member extends Equatable {
  const Member(
      {required this.id, required this.userId, required this.eventIid});

  final int id;
  final int userId;
  final int eventIid;

  //Equatable
  @override
  List<Object?> get props => [id, userId, eventIid];
}

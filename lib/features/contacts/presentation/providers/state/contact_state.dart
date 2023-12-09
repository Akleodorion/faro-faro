import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';

class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends ContactState {}

class Loaded extends ContactState {
  Loaded({required this.contacts, required this.message});

  final List<Contact> contacts;
  final String message;
}

class Error extends ContactState {
  Error({required this.message});
  final String message;
}

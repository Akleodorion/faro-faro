import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';

abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends AddressState {}

class Loading extends AddressState {}

class Loaded extends AddressState {
  final Address address;

  Loaded({required this.address});
}

class Error extends AddressState {
  final String message;

  Error({required this.message});
}

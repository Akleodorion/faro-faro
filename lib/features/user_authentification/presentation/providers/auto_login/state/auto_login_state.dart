import 'package:equatable/equatable.dart';

abstract class AutoLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends AutoLoginState {}

class Loaded extends AutoLoginState {
  final Map<String, dynamic> userInfo;

  Loaded({required this.userInfo});
}

import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required email,
    required username,
    required phoneNumber,
  }) : super(username: username, email: email, phoneNumber: phoneNumber);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    getJsonInfo(Map<String, dynamic> json, String name) {
      return json['status']['data']['user'][name];
    }

    return UserModel(
      email: getJsonInfo(json, 'email'),
      username: getJsonInfo(json, 'username'),
      phoneNumber: getJsonInfo(json, 'phone_number'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": username,
      "phone_number": phoneNumber,
    };
  }
}

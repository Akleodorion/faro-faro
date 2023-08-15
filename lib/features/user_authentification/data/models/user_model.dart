import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required email,
    required username,
    required id,
    required phoneNumber,
  }) : super(
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          id: id,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, bool logIn) {
    getJsonInfo(Map<String, dynamic> json, String name) {
      if (logIn) {
        return json['status']['data']['user'][name];
      } else {
        return json['status']['data'][name];
      }
    }

    return UserModel(
        email: getJsonInfo(json, 'email'),
        username: getJsonInfo(json, 'username'),
        id: getJsonInfo(json, 'id'),
        phoneNumber: getJsonInfo(json, 'phone_number'));
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": username,
      "phone_number": phoneNumber,
      "id": id,
    };
  }
}

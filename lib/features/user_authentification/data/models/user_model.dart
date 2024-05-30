// Project imports:
import '../../domain/entities/user.dart';

class UserModel extends User {
  // ignore: use_super_parameters
  const UserModel({
    required email,
    required username,
    required id,
    required jwtToken,
    required phoneNumber,
  }) : super(
          username: username,
          email: email,
          jwtToken: jwtToken,
          phoneNumber: phoneNumber,
          id: id,
        );

  factory UserModel.fromJson(
      Map<String, dynamic> json, bool logIn, String jwtToken) {
    getJsonInfo(Map<String, dynamic> json, String name) {
      if (logIn) {
        return json['status']['data']['user'][name];
      } else {
        return json['data'][name];
      }
    }

    return UserModel(
        email: getJsonInfo(json, 'email'),
        username: getJsonInfo(json, 'username'),
        id: getJsonInfo(json, 'id'),
        jwtToken: jwtToken,
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

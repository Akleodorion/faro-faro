// Project imports:
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel(
      {required super.userId,
      required super.phoneNumber,
      required super.username});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      userId: json["user_id"],
      phoneNumber: json["phone_number"],
      username: json["username"],
    );
  }
}

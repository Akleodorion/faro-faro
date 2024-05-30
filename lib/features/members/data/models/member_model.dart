// Project imports:
import 'package:faro_faro/features/members/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel(
      {required super.id,
      required super.userId,
      required super.eventId,
      required super.username});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        id: json["id"],
        userId: json["user_id"],
        username: json["username"],
        eventId: json["event_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "event_id": eventId,
      "username": username
    };
  }
}

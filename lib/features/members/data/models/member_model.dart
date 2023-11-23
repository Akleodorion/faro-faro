import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.userId,
    required super.eventId,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        id: json["member"]["id"],
        userId: json["member"]["user_id"],
        eventId: json["member"]["event_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "event_id": eventId,
    };
  }
}

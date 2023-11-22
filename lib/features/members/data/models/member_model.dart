import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.userId,
    required super.eventIid,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        id: json["id"], userId: json["user_id"], eventIid: json["event_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "event_id": eventIid,
    };
  }
}

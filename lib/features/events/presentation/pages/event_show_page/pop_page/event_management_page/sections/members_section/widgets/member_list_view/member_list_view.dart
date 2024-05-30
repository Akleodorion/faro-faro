// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/widgets/member_card.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';

class MembersListView extends StatelessWidget {
  const MembersListView(
      {super.key,
      required this.mediaHeight,
      required this.memberList,
      required this.event});

  final double mediaHeight;
  final List<MemberModel> memberList;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: memberList.length,
        itemBuilder: (BuildContext context, int index) {
          return MemberCard(
            member: memberList[index],
            event: event,
          );
        },
      ),
    );
  }
}

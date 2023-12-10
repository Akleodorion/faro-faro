import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/member_card.dart';
import 'package:flutter/material.dart';

class MembersListView extends StatelessWidget {
  const MembersListView(
      {super.key,
      required this.mediaHeight,
      required this.memberList,
      required this.event});

  final double mediaHeight;
  final List<Member> memberList;
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

import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/widgets/add_member/add_member.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/widgets/member_list_view/member_list_view.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:flutter/material.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({
    super.key,
    required this.mediaHeight,
    required this.event,
  });

  final double mediaHeight;
  final Event event;

  @override
  Widget build(BuildContext context) {
    final List<MemberModel> memberList = event.members;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Membres de l'évènement",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AddMember(mediaHeight: mediaHeight, event: event),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        MembersListView(
          mediaHeight: mediaHeight,
          memberList: memberList,
          event: event,
        )
      ],
    );
  }
}

import '../../../../../../features/events/domain/entities/event.dart';
import 'list_view_layout.dart';
import 'package:flutter/material.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.title,
    required this.events,
  });

  final String title;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    final double listViewHeight = getListViewHeight(context);

    return SizedBox(
      height: listViewHeight,
      child: ListViewLayout(
        listViewTitle: title,
        events: events,
        listViewHeight: listViewHeight,
      ),
    );
  }

  double getListViewHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bool screenHeightIsMini = screenHeight < 580;
    final bool screenHeightIsStandard = screenHeight < 700;

    if (screenHeightIsMini) {
      return 280;
    }

    if (screenHeightIsStandard) {
      return 320;
    }

    return 350;
  }
}

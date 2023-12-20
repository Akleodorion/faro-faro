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
    late double listViewHeight;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool screenIsMini = screenWidth < 350 && screenHeight < 580;
    final bool screenIsSmall = screenWidth < 415 && screenHeight < 700;

    if (screenIsMini) {
      listViewHeight = 280;
    } else if (screenIsSmall) {
      listViewHeight = 300;
    } else {
      listViewHeight = 330;
    }
    return SizedBox(
      height: listViewHeight,
      child: ListViewLayout(
        listViewTitle: title,
        events: events,
        listViewHeight: listViewHeight,
      ),
    );
  }
}

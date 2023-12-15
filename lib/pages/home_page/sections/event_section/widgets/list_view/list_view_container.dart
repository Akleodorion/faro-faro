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
    print(screenHeight);

    if (screenHeight <= 750) {
      listViewHeight = screenHeight * 0.45;
    } else if (screenHeight >= 750 && screenHeight <= 1000) {
      listViewHeight = screenHeight * 0.37;
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

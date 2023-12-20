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

    print(screenHeight);
    print(screenWidth);

    if (screenHeight <= 600) {
      listViewHeight = 280;
    } else if (screenHeight >= 600 && screenHeight <= 700) {
      listViewHeight = 300;
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

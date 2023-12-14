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
    return SizedBox(
      height: 310,
      child: ListViewLayout(
        listViewTitle: title,
        events: events,
      ),
    );
  }
}

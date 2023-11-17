import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/event_list_section/widgets/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/events/domain/entities/event.dart';
import '../../../features/user_authentification/presentation/providers/state/user_state.dart'
    as us;

class MyEventList extends ConsumerWidget {
  const MyEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Event> events = ref.read(eventsProvider);
    List<Event> myEvents = [];
    final userState = ref.read(userAuthProvider);
    Widget content = const Placeholder(
      fallbackHeight: 200,
    );

    if (userState is us.Loaded) {
      myEvents =
          events.where((event) => event.userId == userState.user.id).toList();
    }

    if (myEvents.isNotEmpty) {
      content = SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: myEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return EventTile(event: myEvents[index]);
          },
        ),
      );
    }

    return content;
  }
}

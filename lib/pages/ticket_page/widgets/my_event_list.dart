import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyEventList extends ConsumerWidget {
  const MyEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myEvents = ref.read(myEventProvider);
    Widget content;

    if (myEvents.isEmpty) {
      content = const Center(
        child: Text(
            "Vous n'avez pas crée d'évènement!\nN'hésitez pas à le faire!"),
      );
    } else {
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

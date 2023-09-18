import '../../features/events/presentation/providers/event_provider.dart';
import '../../features/events/presentation/providers/state/event_state.dart';
import 'widget/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: screenHeight * 0.06,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 0,
                        ),
                      ]),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list_alt,
                    size: 40,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Evènements disponibles"),
            const SizedBox(
              height: 20,
            ),
            if (eventState is Loaded)
              Expanded(
                child: ListView.builder(
                  itemCount: eventState.indexEvent.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EventTile(event: eventState.indexEvent[index]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:faro_clean_tdd/pages/home_page/widgets/List_view_row.dart';
import 'package:faro_clean_tdd/pages/home_page/widgets/upper_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/events/presentation/providers/event_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    final double screenHeight = MediaQuery.of(context).size.height;

    late Widget content;
    if (eventState is Loading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: (screenHeight) * 0.05, child: const UpperRow()),
            SizedBox(
              height: (MediaQuery.of(context).size.height) * 0.76,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 355,
                      child: ListViewRow(
                        listViewTitle: "Random",
                        events:
                            eventState is Loaded ? eventState.randomEvents : [],
                      ),
                    ),
                    SizedBox(
                      height: 355,
                      child: ListViewRow(
                        listViewTitle: "Upcoming",
                        events: eventState is Loaded
                            ? eventState.upcomingEvents
                            : [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return content;
  }
}

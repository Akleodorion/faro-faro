import '../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import '../../features/events/presentation/providers/fetch_event/state/fetch_event_state.dart';
import 'sections/event_section/event_section.dart';
import 'sections/user_and_search_section/user_and_search_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Widget content;
    final eventState = ref.watch(fetchEventProvider);

    if (eventState is Loading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserAndSearchSection(),
            EventSection(),
          ],
        ),
      );
    }

    return content;
  }
}

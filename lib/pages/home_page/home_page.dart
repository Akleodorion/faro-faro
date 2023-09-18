import '../../features/events/presentation/providers/event_provider.dart';
import '../../features/events/presentation/providers/state/event_state.dart';
import 'sections/event_section/event_section.dart';
import 'sections/user_and_search_section/user_and_search_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    late Widget content;
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

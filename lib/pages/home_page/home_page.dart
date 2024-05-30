// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import '../../features/events/presentation/providers/fetch_event/state/fetch_event_state.dart';
import 'sections/event_section/event_section.dart';
import 'sections/user_and_search_section/user_and_search_section.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

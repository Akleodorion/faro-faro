import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:faro_clean_tdd/pages/home_page/widgets/random_row.dart';
import 'package:faro_clean_tdd/pages/home_page/widgets/upper_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/events/presentation/providers/event_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    late Widget content;
    if (eventState is Loading) {
      content = const CircularProgressIndicator();
    } else {
      content = Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UpperRow(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 360,
                child: RandomRow(
                  events: eventState is Loaded ? eventState.indexEvent : [],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 360,
                child: RandomRow(
                  events: eventState is Loaded ? eventState.indexEvent : [],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return content;
  }
}

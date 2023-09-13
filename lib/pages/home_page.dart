import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    late Widget content;
    if (eventState is Loading) {
      content = const CircularProgressIndicator();
    } else {
      content = const Text("hello world!");
    }
    return Center(
      child: content,
    );
  }
}

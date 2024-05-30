// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/action_button.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/my_spacer.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/member_section.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/status_section/status_section.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/tickets_section/ticket_section.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';

class EventManagementPage extends ConsumerWidget {
  const EventManagementPage({super.key, required this.eventId});
  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref
        .watch(allEventProvider)
        .firstWhere((element) => element.id == eventId);

    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Gestion de l'évènement"),
        actions: [ActionButton(event: event)],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(42, 43, 42, 1),
              Color.fromRGBO(42, 43, 42, 0.2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 8,
          ),
          child: Column(
            children: [
              MembersSection(
                mediaHeight: mediaHeight,
                event: event,
              ),
              const MySpacer(thickness: 0.2),
              TicketsSection(
                event: event,
              ),
              const MySpacer(thickness: 0.4),
              StatusSection(
                event: event,
              )
            ],
          ),
        ),
      ),
    );
  }
}

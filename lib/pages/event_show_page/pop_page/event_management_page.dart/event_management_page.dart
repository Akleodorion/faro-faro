import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/action_button.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/my_spacer.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/member_section.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/status_section/status_section.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/tickets_section/ticket_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventManagementPage extends ConsumerWidget {
  const EventManagementPage({super.key, required this.eventId});
  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = ref.read(contactsListProvider);
    final event = ref
        .watch(allEventProvider)
        .firstWhere((element) => element.eventId == eventId);

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
                contactList: contactList,
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

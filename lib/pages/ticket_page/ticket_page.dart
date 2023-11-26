import 'package:faro_clean_tdd/pages/ticket_page/widgets/my_event_list.dart';
import 'package:faro_clean_tdd/pages/ticket_page/widgets/my_ticket_list.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage(
      {super.key, required this.setEvent, required this.isMyTicket});

  final void Function(bool value) setEvent;
  final bool isMyTicket;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  ButtonStyle unSelectedPageStyle = TextButton.styleFrom(
    foregroundColor: Colors.grey,
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    ),
  );

  ButtonStyle selectedPageStyle = TextButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    ),
  );

  @override
  Widget build(BuildContext context) {
    bool isMyTicket = widget.isMyTicket;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  widget.setEvent(true);
                },
                style: isMyTicket == true
                    ? selectedPageStyle
                    : unSelectedPageStyle,
                child: const Text(
                  "Mes tickets",
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.setEvent(false);
                },
                style: isMyTicket == false
                    ? selectedPageStyle
                    : unSelectedPageStyle,
                child: const Text("Mes Evènements"),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isMyTicket ? const MyTicketList() : const MyEventList(),
          )
        ],
      ),
    );
  }
}

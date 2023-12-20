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
  @override
  Widget build(BuildContext context) {
    ButtonStyle unSelectedPageStyle = TextButton.styleFrom(
      foregroundColor: Colors.grey,
      textStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );

    ButtonStyle selectedPageStyle = TextButton.styleFrom(
      textStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );

    bool isMyTicket = widget.isMyTicket;

    return SingleChildScrollView(
      child: Center(
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
      ),
    );
  }
}

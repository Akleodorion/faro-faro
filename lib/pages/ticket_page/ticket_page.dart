import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.setEvent});

  final void Function(bool value) setEvent;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isMyTicket = false;
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isMyTicket = true;
                  });
                  widget.setEvent(false);
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
                  setState(() {
                    isMyTicket = false;
                  });
                  widget.setEvent(true);
                },
                style: isMyTicket == false
                    ? selectedPageStyle
                    : unSelectedPageStyle,
                child: const Text("Mes Evènements"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

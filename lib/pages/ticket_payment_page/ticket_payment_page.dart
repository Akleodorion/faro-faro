import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/ticket_payment_page/widgets/buy_ticket_card.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class TicketPaymentPage extends StatefulWidget {
  const TicketPaymentPage({super.key, required this.event});

  final Event event;

  @override
  State<TicketPaymentPage> createState() => _TicketPaymentPageState();
}

class _TicketPaymentPageState extends State<TicketPaymentPage> {
  late bool isFree;
  int standardTicketNumber = 0;
  int goldTicketNumber = 0;
  int platinumTicketNumber = 0;

  @override
  Widget build(BuildContext context) {
    widget.event.modelEco == ModelEco.gratuit ? isFree = true : isFree = false;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Achetez vos tickets"),
        centerTitle: true,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Column(
              children: [
                Text(
                  widget.event.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                BuyTicketCard(
                  ticketNumber: standardTicketNumber,
                  ticketPrice: widget.event.standardTicketPrice,
                  ticketLeft: widget.event.standardTicketLeft,
                  ticketType: Type.standard.name,
                  incrOrDecr: (value) {
                    if (value) {
                      standardTicketNumber >=
                              widget.event.standardTicketCountLeft
                          ? null
                          : setState(() => standardTicketNumber++);
                    } else {
                      standardTicketNumber <= 0
                          ? null
                          : setState(() => standardTicketNumber--);
                    }
                  },
                ),
                if (widget.event.maxGoldTicket != null) const MySpacer(),
                if (widget.event.maxGoldTicket != null)
                  BuyTicketCard(
                    ticketNumber: goldTicketNumber,
                    ticketPrice: widget.event.goldTicketPrice,
                    ticketLeft: widget.event.goldTicketLeft,
                    ticketType: Type.gold.name,
                    incrOrDecr: (value) {
                      if (value) {
                        goldTicketNumber >= widget.event.goldTicketCountLeft!
                            ? null
                            : setState(() => goldTicketNumber++);
                      } else {
                        goldTicketNumber <= 0
                            ? null
                            : setState(() => goldTicketNumber--);
                      }
                    },
                  ),
                if (widget.event.maxPlatinumTicket != null) const MySpacer(),
                if (widget.event.maxPlatinumTicket != null)
                  BuyTicketCard(
                    ticketNumber: platinumTicketNumber,
                    ticketPrice: widget.event.platinumTicketPrice,
                    ticketLeft: widget.event.platinumTicketLeft,
                    ticketType: Type.platinum.name,
                    incrOrDecr: (value) {
                      if (value) {
                        platinumTicketNumber >=
                                widget.event.platinumTicketCountLeft!
                            ? null
                            : setState(() => platinumTicketNumber++);
                      } else {
                        platinumTicketNumber <= 0
                            ? null
                            : setState(() => platinumTicketNumber--);
                      }
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MySpacer extends StatelessWidget {
  const MySpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 0.5,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

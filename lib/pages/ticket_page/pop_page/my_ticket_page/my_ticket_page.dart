import 'package:faro_clean_tdd/core/util/capitalize_first_letter.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/my_ticket_page/sections/image_section/image_section.dart';
import 'package:flutter/material.dart';

class MyTicketPage extends StatelessWidget {
  const MyTicketPage({
    super.key,
    required this.ticket,
    required this.event,
  });

  final Ticket ticket;
  final Event event;

  @override
  Widget build(BuildContext context) {
    final double mediaHeight = MediaQuery.of(context).size.height;
    final double mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: Column(
          children: [
            ImageSection(
              mediaHeight: mediaHeight,
              eventImageUrl: event.imageUrl,
              ticket: ticket,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: SizedBox(
                height: mediaHeight * 0.47,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          "Ticket: ${ticket.type.name}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: (mediaWidth * 0.5 - 40),
                            child: Text(
                              event.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(
                            width: (mediaWidth * 0.5 - 40),
                            child: Text(event.eventTimeFrame,
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (mediaWidth * 1 - 40),
                            child: Text(
                              "${CapitalizeFirstLetterImpl().capitalizeInput(event.category.name)} : ${event.address.getFullFormattedAddress()}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Description : ",
                                style: Theme.of(context).textTheme.titleLarge),
                            TextSpan(
                                text: ticket.description,
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Align(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                ticket.qrCodeUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

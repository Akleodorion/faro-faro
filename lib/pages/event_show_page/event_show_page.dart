import 'package:faro_clean_tdd/core/util/capitalize_first_letter.dart';
import 'package:faro_clean_tdd/core/util/number_formatter.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/event_show_page/widgets/image_container.dart';
import 'package:flutter/material.dart';

class EventShowPage extends StatelessWidget {
  const EventShowPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final double mediaHeight = MediaQuery.of(context).size.height;
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
            ImageContainer(imageUrl: event.imageUrl),
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
                      Text(
                        event.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "${CapitalizeFirstLetterImpl().capitalizeInput(event.category.name)} : ${event.location}",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.pin_drop_outlined,
                                  size: 24,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            ],
                          ),
                          Text("World XXXXXX",
                              style: Theme.of(context).textTheme.bodyMedium),
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
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Tarifs",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                              "Ticket Standard : ${NumberFormatterImpl().formatNumber(event.standardTicketPrice)} XOF")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                              "Ticket VIP : ${NumberFormatterImpl().formatNumber(event.vipTicketPrice)} XOF")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                              "Ticket VVIP : ${NumberFormatterImpl().formatNumber(event.vvipTicketPrice)} XOF")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Localisation",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 10,
                      ),
                      Placeholder(
                        fallbackHeight: mediaHeight * 0.2,
                      )
                    ],
                  ),
                ),
              ),
            ),
            UsecaseElevatedButton(
                usecaseTitle: "Achète ton ticket", onUsecaseCall: () {})
          ],
        ),
      ),
    );
  }
}

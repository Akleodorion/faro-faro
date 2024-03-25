import 'package:faro_clean_tdd/core/util/capitalize_first_letter.dart';
import 'package:faro_clean_tdd/core/util/number_formatter.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/widgets/image_container.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/pages/ticket_payment_page/ticket_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'pop_page/map_page.dart';

class EventShowPage extends ConsumerWidget {
  const EventShowPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double mediaHeight = MediaQuery.of(context).size.height;
    final double mediaWidth = MediaQuery.of(context).size.width;
    bool isMine;
    final bool isFree = event.modelEco == ModelEco.gratuit;

    final userInfo = ref.read(userInfoProvider);
    userInfo["user_id"] == event.userId ? isMine = true : isMine = false;

    // Widget
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
            ImageContainer(
              event: event,
              isMine: isMine,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: mediaHeight * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
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
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (mediaWidth * 1 - 40),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          "${CapitalizeFirstLetterImpl().capitalizeInput(event.category.name)} :",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  TextSpan(
                                      text: event.address.getFullAddress(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall)
                                ],
                              ),
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
                                style: Theme.of(context).textTheme.bodyLarge),
                            TextSpan(
                                text: event.description,
                                style: Theme.of(context).textTheme.bodySmall)
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
                      Column(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 4,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  event.modelEco == ModelEco.gratuit
                                      ? "Ticket Standard : Gratuit - ${event.standardTicketLeft}"
                                      : "Ticket Standard : ${NumberFormatterImpl().formatNumber(event.standardTicketPrice!)} XOF - ${event.standardTicketLeft}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: mediaWidth - 50,
                                child: Text(
                                  event.standardTicketDescription,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (event.modelEco != ModelEco.gratuit)
                        const SizedBox(
                          height: 5,
                        ),
                      if (event.modelEco != ModelEco.gratuit)
                        const Divider(
                          thickness: 0.1,
                        ),
                      if (event.goldTicketDescription == null ? false : true)
                        Column(
                          children: [
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
                                  "Ticket Gold : ${NumberFormatterImpl().formatNumber(event.goldTicketPrice!)} XOF - ${event.goldTicketLeft}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                            Row(children: [
                              SizedBox(
                                width: mediaWidth - 40,
                                child: Text(
                                  event.goldTicketDescription!,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ])
                          ],
                        ),
                      if (event.modelEco != ModelEco.gratuit)
                        const SizedBox(
                          height: 5,
                        ),
                      if (event.modelEco != ModelEco.gratuit)
                        const Divider(
                          thickness: 0.1,
                        ),
                      if (event.modelEco != ModelEco.gratuit)
                        Column(
                          children: [
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
                                  "Ticket Platinum : ${NumberFormatterImpl().formatNumber(event.platinumTicketPrice!)} XOF - ${event.platinumTicketLeft}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaWidth - 40,
                                  child: Text(
                                    "Description : ${event.platinumTicketDescription}",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            )
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
                      Container(
                        height: mediaHeight * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push<LatLng>(MaterialPageRoute(builder: (ctx) {
                              return MapScreen(
                                markerLat: event.address.latitude,
                                markerLng: event.address.longitude,
                              );
                            }));
                          },
                          child: Image.network(
                            event.address.geocodeUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!isMine)
                        Align(
                          alignment: Alignment.center,
                          child: UsecaseElevatedButton(
                            usecaseTitle: isFree
                                ? "Réserve ton ticket"
                                : "Achète ton ticket",
                            onUsecaseCall: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return TicketPaymentPage(
                                      event: event,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

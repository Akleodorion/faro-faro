import 'package:faro_clean_tdd/core/util/capitalize_first_letter.dart';
import 'package:faro_clean_tdd/core/util/number_formatter.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/event_show_page/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'pop_page/map_page.dart';

class EventShowPage extends StatelessWidget {
  const EventShowPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final double mediaHeight = MediaQuery.of(context).size.height;
    final double mediaWidth = MediaQuery.of(context).size.width;
    final String geocoderUrl =
        "https://maps.googleapis.com/maps/api/staticmap?center=${event.latitude},${event.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${event.latitude},${event.longitude}&key=${dotenv.env['API_KEY']}";
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (mediaWidth * 0.6 - 20),
                            child: Text(
                                "${CapitalizeFirstLetterImpl().capitalizeInput(event.category.name)} : ${event.address}",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          SizedBox(
                            width: (mediaWidth * 0.4 - 20),
                            child: Text(
                                DateFormat('dd/MM/yyyy').format(event.date),
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodyMedium),
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
                                text: event.description,
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
                              Text(event.modelEco == ModelEco.gratuit
                                  ? "Ticket Standard : Gratuit"
                                  : "Ticket Standard : ${NumberFormatterImpl().formatNumber(event.standardTicketPrice)} XOF")
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Description : ${event.standardTicketDescription}",
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                        ],
                      ),
                      if (event.modelEco != ModelEco.gratuit)
                        const SizedBox(
                          height: 10,
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
                                    "Ticket VIP : ${NumberFormatterImpl().formatNumber(event.vipTicketPrice)} XOF")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Description : ${event.vipTicketDescription}",
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )
                          ],
                        ),
                      if (event.modelEco != ModelEco.gratuit)
                        const SizedBox(
                          height: 10,
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
                                    "Ticket VVIP : ${NumberFormatterImpl().formatNumber(event.vvipTicketPrice)} XOF")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Description : ${event.vvipTicketDescription}",
                                  textAlign: TextAlign.start,
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
                                markerLat: event.latitude,
                                markerLng: event.longitude,
                              );
                            }));
                          },
                          child: Image.network(
                            geocoderUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
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

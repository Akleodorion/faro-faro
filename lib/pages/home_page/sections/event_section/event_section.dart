import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/event_show_page.dart';

import '../../../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'widgets/list_view/list_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventSection extends ConsumerWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content;

    final upcomingEvents = ref.read(upcomingEventProvider);
    final randomEvents = ref.read(randomEventsProvider);
    final allEvents = ref.read(allEventProvider);

    if (allEvents.isEmpty) {
      content = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("We are sorry, no event currently available "),
            SizedBox(
              height: 10,
            ),
            Text("Try to add one !"),
          ],
        ),
      );
    } else if (allEvents.length < 10) {
      content = Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            const Text("Hello World"),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                children: [
                  for (final event in allEvents)
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return EventShowPage(event: event);
                        }));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[3]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 190,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(event.imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                event.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "${event.formatedDate} - ${event.address.getFormattedAddress()}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "A partir de:",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    event.modelEco == ModelEco.gratuit
                                        ? "Gratuit"
                                        : "${event.standardTicketPrice} XOF",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      content = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListViewContainer(title: "Random", events: randomEvents),
            ListViewContainer(title: "Upcoming", events: upcomingEvents),
          ],
        ),
      );
    }

    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.76,
      child: content,
    );
  }
}

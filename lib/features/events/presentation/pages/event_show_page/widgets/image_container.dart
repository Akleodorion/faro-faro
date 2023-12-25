import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/event_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.event, required this.isMine});

  final Event event;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight * 0.40,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(event.imageUrl),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: screenHeight * 0.40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.05,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.9)),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
        if (isMine)
          Positioned(
              top: screenHeight * 0.05,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.9)),
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, child) {
                    return PopupMenuButton(
                      color: Theme.of(context).colorScheme.background,
                      icon: const Icon(Icons.dehaze),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuItem>[
                          PopupMenuItem(
                            child: TextButton.icon(
                              label: const Text("Modifier l'évènement"),
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton.icon(
                              label: const Text("Gestion de l'évènement"),
                              onPressed: () {
                                Navigator.of(context).pop();

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return EventManagementPage(
                                        eventId: event.id!,
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(Icons.settings),
                            ),
                          )
                        ];
                      },
                    );
                  },
                ),
              ))
      ],
    );
  }
}

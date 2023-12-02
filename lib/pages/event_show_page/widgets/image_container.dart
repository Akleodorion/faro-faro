import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/member_page/member_page.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.event});

  final Event event;

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
        Positioned(
          top: screenHeight * 0.05,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.9)),
            child: PopupMenuButton(
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
                      label: const Text("Fermer l'évènement"),
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      label: const Text("Activer l'évènement"),
                      onPressed: () {},
                      icon: const Icon(Icons.done_outline),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      label: const Text("Gérer les membres"),
                      onPressed: () {
                        //Ferme le pop menu item
                        Navigator.of(context).pop();

                        // Redirige vers la page de gestion des membres
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MemberPage(
                                event: event,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  )
                ];
              },
            ),
          ),
        )
      ],
    );
  }
}

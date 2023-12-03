import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/member_page/member_page.dart';
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
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: const Text("Fermer l'évènement:"),
                                  content: const Text(
                                      "Etes-vous sûr de vouloir fermer l'évènement ? Il sera supprimé définitivement."),
                                  actions: [
                                    Consumer(
                                      builder: (BuildContext context,
                                          WidgetRef ref, Widget? child) {
                                        return IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        label: const Text("Activer l'évènement"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: const Text("Activer l'évènement:"),
                                  content: const Text(
                                      "Voulez-vous activer l'évènement ? Vous ne pourrez plus le désactiver par la suite."),
                                  actions: [
                                    Consumer(
                                      builder: (BuildContext context,
                                          WidgetRef ref, Widget? child) {
                                        return IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
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

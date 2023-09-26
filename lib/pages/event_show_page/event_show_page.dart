import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/event_show_page/widgets/imaga_container.dart';
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
                height: mediaHeight * 0.45,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hello XXXXXX"),
                          Text("World XXXXXX"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          "${event.name}: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Tarifs"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.panorama_fish_eye_outlined,
                            size: 8,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Ticket Standard : 5000 XOF")
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.panorama_fish_eye_outlined,
                            size: 8,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Ticket VIP : 10 000 XOF")
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.panorama_fish_eye_outlined,
                            size: 8,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Ticket VVIP : 15 000 XOF")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Localisation"),
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

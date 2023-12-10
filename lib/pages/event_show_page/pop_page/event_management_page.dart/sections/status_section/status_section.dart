import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/activate_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusSection extends ConsumerWidget {
  const StatusSection({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Widget content;
    late Widget activatedContent;

    if (event.activated) {
      activatedContent = const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "L'évènement a commencé",
          ),
        ],
      );
    } else {
      activatedContent = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "L'évènement n'a pas commencé",
          ),
          TextButton.icon(
            label: const Text("Démmarez l'évènement!"),
            onPressed: () async {
              await usecaseAlertDialog(
                context: context,
                title: "Démmarez l'évènement!",
                content:
                    "Voulez-vous démarrer l'évènement ?\n\nVous ne pourrez plus le désactiver par la suite.",
                usecase: () async {
                  final activateEventState = await ref
                      .read(activateEventStateProvider.notifier)
                      .activateAnEvent(eventId: event.eventId);
                  switch (activateEventState) {
                    case Loaded():
                      ref
                          .read(fetchEventProvider.notifier)
                          .setEventActivatedToTrue(
                            event: event,
                            fetchEventState: ref.read(fetchEventProvider),
                          );
                      if (context.mounted) {
                        showResultMessageSnackbar(
                          context: context,
                          message: activateEventState.message,
                        );
                      }
                      break;
                    case Error():
                      if (context.mounted) {
                        showResultMessageSnackbar(
                          context: context,
                          message: activateEventState.message,
                        );
                      }

                      break;
                    default:
                  }
                },
              );
            },
            icon: const Icon(Icons.done, size: 24),
          )
        ],
      );
    }

    if (event.closed) {
      content = const SizedBox(
        height: 200,
        child: Center(
          child: Text("L'évènement est fermé"),
        ),
      );
    } else {
      content = activatedContent;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Status de l'évènement:",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        content,
      ],
    );
  }
}

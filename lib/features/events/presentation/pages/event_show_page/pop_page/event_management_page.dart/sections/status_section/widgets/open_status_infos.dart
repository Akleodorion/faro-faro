import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/activate_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenStatusInfos extends ConsumerWidget {
  const OpenStatusInfos({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Widget content;

    if (event.activated) {
      content = const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "L'évènement a débuté",
          ),
        ],
      );
    } else {
      content = Row(
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
                      .activateAnEvent(eventId: event.id!);

                  if (context.mounted) {
                    activateEvent(
                      context: context,
                      activateEventState: activateEventState,
                    );
                  }
                },
              );
            },
            icon: const Icon(Icons.done, size: 24),
          )
        ],
      );
    }

    return content;
  }

  void activateEvent({
    required BuildContext context,
    required ActivateEventState activateEventState,
  }) {
    final bool isSuccess = activateEventState is Loaded && context.mounted;
    final bool isError = activateEventState is Error && context.mounted;

    if (isSuccess) {
      showResultMessageSnackbar(
          context: context, message: activateEventState.message);
    }

    if (isError) {
      showResultMessageSnackbar(
          context: context, message: activateEventState.message);
    }
  }
}

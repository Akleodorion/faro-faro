// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/util/show_result_message_snackbar.dart';
import 'package:faro_faro/core/util/usecase_alert_dialog.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/providers/activate_event/activate_event_provider.dart';
import 'package:faro_faro/features/events/presentation/providers/activate_event/state/activate_event_state.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';

class OpenStatusInfos extends ConsumerWidget {
  const OpenStatusInfos({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Widget content;

    void activateEvent({
      required BuildContext context,
      required ActivateEventState activateEventState,
    }) {
      final bool isSuccess = activateEventState is Loaded && context.mounted;
      final bool isError = activateEventState is Error && context.mounted;

      if (isSuccess) {
        final fetchEventState = ref.read(fetchEventProvider);
        ref.read(fetchEventProvider.notifier).setEventActivatedToTrue(
            event: event, fetchEventState: fetchEventState);
        showResultMessageSnackbar(
            context: context, message: activateEventState.message);
      }

      if (isError) {
        showResultMessageSnackbar(
            context: context, message: activateEventState.message);
      }
    }

    if (event.activated) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "L'évènement a débuté",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    } else {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "L'évènement n'a pas commencé",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            child: const Text("Commencer"),
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
          )
        ],
      );
    }

    return content;
  }
}

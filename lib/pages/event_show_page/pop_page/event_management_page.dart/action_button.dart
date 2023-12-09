import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/close_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/state/close_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionButton extends ConsumerWidget {
  const ActionButton({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        await usecaseAlertDialog(
          context: context,
          title: "Clôturer l'évènement:",
          content:
              "Etes-vous sûr de vouloir clôturer l'évènement ?\n\nIl sera supprimé définitivement.",
          usecase: () async {
            final stateResult = await ref
                .read(closeEventStateProvider.notifier)
                .closeAnEvent(eventId: event.eventId);
            switch (stateResult) {
              case Loaded():
                if (context.mounted) {
                  showResultMessageSnackbar(
                    context: context,
                    message: "Evènement cloturé avec succès",
                  );
                  Navigator.of(context).pop();
                }
                break;
              case Error():
                if (context.mounted) {
                  showResultMessageSnackbar(
                    context: context,
                    message: stateResult.message,
                  );
                  Navigator.of(context).pop();
                }
              default:
            }
          },
        );
      },
      icon: const Icon(Icons.close_rounded),
    );
  }
}

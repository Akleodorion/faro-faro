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

            if (context.mounted) {
              action(context, stateResult);
            }
          },
        );
      },
      icon: const Icon(Icons.close_rounded),
    );
  }

  //Méthodes locales

  void action(BuildContext context, CloseEventState closeEventState) async {
    final bool isSuccess = closeEventState is Loaded && context.mounted;
    final bool isFailure = closeEventState is Error && context.mounted;

    if (isSuccess) {
      showResultMessageSnackbar(
        context: context,
        message: closeEventState.message,
      );
    }

    if (isFailure) {
      showResultMessageSnackbar(
        context: context,
        message: closeEventState.message,
      );
    }
    Navigator.of(context).pop();
  }
}

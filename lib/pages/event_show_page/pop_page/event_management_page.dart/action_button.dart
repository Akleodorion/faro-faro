import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/close_event_provider.dart';
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
            await ref
                .read(closeEventStateProvider.notifier)
                .closeAnEvent(eventId: event.eventId);
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}

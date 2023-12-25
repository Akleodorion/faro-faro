import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/status_section/widgets/open_status_infos.dart';
import 'package:flutter/material.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Status de l'évènement:",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        event.closed
            ? SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    "L'évènement est fermé",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            : OpenStatusInfos(event: event),
      ],
    );
  }
}

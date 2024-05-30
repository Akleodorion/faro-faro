// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/ticket_input_form.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/post_event_provider.dart';

class TicketColumn extends ConsumerWidget {
  const TicketColumn(
      {super.key,
      required this.setStandardTicketDescription,
      required this.setStandardTicketNumber,
      required this.setStandardTicketPrice,
      required this.setGoldTicketDescription,
      required this.setGoldTicketNumber,
      required this.setGoldTicketPrice,
      required this.setPlatinumTicketDescription,
      required this.setPlatinumTicketNumber,
      required this.setPlatinumTicketPrice});

  final void Function(String? value) setStandardTicketDescription;
  final void Function(int? value) setStandardTicketNumber;
  final void Function(int? value) setStandardTicketPrice;

  final void Function(String? value) setGoldTicketDescription;
  final void Function(int? value) setGoldTicketNumber;
  final void Function(int? value) setGoldTicketPrice;

  final void Function(String? value) setPlatinumTicketDescription;
  final void Function(int? value) setPlatinumTicketNumber;
  final void Function(int? value) setPlatinumTicketPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFree = ref.watch(postEventModelEcoStatusProvider);

    return Column(
      children: [
        TicketInputForm(
          ticketType: "Standard",
          setTicketDescription: setStandardTicketDescription,
          setTicketNumber: setStandardTicketNumber,
          setTicketPrice: setStandardTicketPrice,
        ),
        if (!isFree)
          TicketInputForm(
            ticketType: "Gold",
            setTicketDescription: setGoldTicketDescription,
            setTicketNumber: setGoldTicketNumber,
            setTicketPrice: setGoldTicketPrice,
          ),
        if (!isFree)
          TicketInputForm(
            ticketType: "Platinum",
            setTicketDescription: setPlatinumTicketDescription,
            setTicketNumber: setPlatinumTicketNumber,
            setTicketPrice: setPlatinumTicketPrice,
          ),
      ],
    );
  }
}

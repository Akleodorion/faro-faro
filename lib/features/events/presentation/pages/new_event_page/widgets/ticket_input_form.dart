import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/new_event_page/widgets/description_text_form_field.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/new_event_page/widgets/number_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketInputForm extends ConsumerStatefulWidget {
  const TicketInputForm(
      {super.key,
      required this.ticketType,
      required this.setTicketDescription,
      required this.setTicketNumber,
      required this.setTicketPrice});

  final String ticketType;

  final void Function(String? value) setTicketDescription;
  final void Function(int? value) setTicketNumber;
  final void Function(int? value) setTicketPrice;

  @override
  ConsumerState<TicketInputForm> createState() => _TicketInputFormState();
}

class _TicketInputFormState extends ConsumerState<TicketInputForm> {
  @override
  Widget build(BuildContext context) {
    final String descriptionMapKey;
    final String quantityMapKey;
    final String priceMapKey;

    bool isFree = ref.watch(postEventModelEcoStatusProvider);

    if (widget.ticketType == "Standard") {
      descriptionMapKey = 'standardTicketDescription';
      quantityMapKey = 'maxStandardTicket';
      priceMapKey = 'standardTicketPrice';
    } else if (widget.ticketType == "Vip") {
      descriptionMapKey = 'vipTicketDescription';
      quantityMapKey = 'maxVipTicket';
      priceMapKey = 'vipTicketPrice';
    } else {
      descriptionMapKey = 'vvipTicketDescription';
      quantityMapKey = 'maxVvipTicket';
      priceMapKey = 'vvipTicketPrice';
    }

    return Column(
      children: [
        Center(
          child: Text('Ticket ${widget.ticketType}',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberInputField(
              trailingText: "Nombre de ticket :",
              isQuantity: true,
              mapKey: quantityMapKey,
              setValue: widget.setTicketNumber,
            ),
            const SizedBox(
              width: 5,
            ),
            if (!isFree)
              NumberInputField(
                trailingText: "Prix d'un ticket :",
                isQuantity: false,
                mapKey: priceMapKey,
                setValue: widget.setTicketPrice,
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        DescriptionTextFormField(
          isTicket: true,
          mapKey: descriptionMapKey,
          setValue: widget.setTicketDescription,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

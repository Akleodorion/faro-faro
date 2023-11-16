import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/description_text_form_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/number_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketInputForm extends ConsumerStatefulWidget {
  const TicketInputForm({super.key, required this.ticketType});

  final String ticketType;

  @override
  ConsumerState<TicketInputForm> createState() => _TicketInputFormState();
}

class _TicketInputFormState extends ConsumerState<TicketInputForm> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postEventProvider);

    final String descriptionMapKey;
    final String quantityMapKey;
    final String priceMapKey;

    bool isFree = true;

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

    if (state is Initial) {
      state.infoMap["modelEco"] == ModelEco.gratuit
          ? isFree = true
          : isFree = false;
    }

    return Column(
      children: [
        Center(
          child: Text('Ticket ${widget.ticketType}',
              style: const TextStyle(
                  fontSize: 20, decoration: TextDecoration.underline)),
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
              onSave: (value) {
                setState(() {
                  // maxStandardTicket = int.tryParse(value);
                });
              },
            ),
            const SizedBox(
              width: 15,
            ),
            if (!isFree)
              NumberInputField(
                trailingText: "Prix d'un ticket :",
                isQuantity: false,
                mapKey: priceMapKey,
                onSave: (value) {
                  setState(() {
                    // standardTicketPrice = int.tryParse(value);
                  });
                },
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        DescriptionTextFormField(
          isTicket: true,
          mapKey: descriptionMapKey,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

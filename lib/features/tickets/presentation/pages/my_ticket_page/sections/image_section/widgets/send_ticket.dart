import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/core/util/permission_handler.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/fonctions/pop_up_dialog.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/pages/my_ticket_page/sections/image_section/functions.dart/pop_up_bottom_seet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendTicket extends ConsumerWidget {
  const SendTicket({
    super.key,
    required this.mediaHeight,
    required this.ticket,
  });

  final double mediaHeight;
  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: mediaHeight * 0.05,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.background.withOpacity(0.9),
        ),
        child: IconButton(
          onPressed: () async {
            final contactState = ref.read(contactStateProvider);

            if (contactState is Loading) {
              try {
                final List<String> numberList = await GetContactListImpl(
                  contactService: ContactServiceImpl(),
                  permissionHandler: PermissionHandlerImp(),
                ).getContacts(context);

                await ref
                    .read(contactStateProvider.notifier)
                    .fetchContact(numberList);
              } on ServerException {
                if (context.mounted) {
                  await popUpDialog(context: context);
                  return;
                }
              }
            }
            if (context.mounted) {
              await popUpBottomSheet(
                context: context,
                mediaHeight: mediaHeight,
                ref: ref,
                ticket: ticket,
              );
            }
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

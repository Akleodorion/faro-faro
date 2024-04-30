import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/permission_handler.dart';
import 'package:faro_clean_tdd/internal_features/contact_list/contact_list.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/widgets/add_member/fonctions/pop_up_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMember extends ConsumerWidget {
  const AddMember({
    super.key,
    required this.mediaHeight,
    required this.event,
  });

  final double mediaHeight;
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      label: const Text("Ajouter un membre"),
      onPressed: () async {
        final contactState = ref.read(contactStateProvider);
        if (contactState is Loading) {
          try {
            await PermissionHandlerImp(
              context: context,
              permissionEnum: PermissionEnum.contact,
            ).requestPermission();
          } on UtilException {
            if (context.mounted) {
              await PermissionHandlerImp(
                context: context,
                permissionEnum: PermissionEnum.contact,
              ).showPermissionErrorDialog();
            }
            return;
          }
          final List<String> numbers =
              await ContactListImpl().retrieveContacts();
          await ref
              .read(contactStateProvider.notifier)
              .fetchContact(numbers: numbers);
        }
        if (context.mounted) {
          await popUpBottomSheet(
            event: event,
            context: context,
            mediaHeight: mediaHeight,
            ref: ref,
          );
        }
      },
      icon: const Icon(Icons.add),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_faro/core/util/permission_handler/permission_handler.dart';
import 'package:faro_faro/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_faro/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/widgets/add_member/fonctions/pop_up_bottom_sheet.dart';
import 'package:faro_faro/internal_features/contact_list/contact_list.dart';

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
            final List<String> numbers =
                await ContactListImpl().retrieveContacts();
            await ref
                .read(contactStateProvider.notifier)
                .fetchContact(numbers: numbers);
          } on UtilException {
            if (context.mounted) {
              await PermissionHandlerImp(
                context: context,
                permissionEnum: PermissionEnum.contact,
              ).showPermissionErrorDialog();
            }
            return;
          }
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

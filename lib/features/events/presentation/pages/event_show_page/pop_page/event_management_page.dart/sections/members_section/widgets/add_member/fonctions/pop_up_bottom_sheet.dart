import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/modal_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> popUpBottomSheet({
  required BuildContext context,
  required double mediaHeight,
  required WidgetRef ref,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ModalBottomSheetLayout(
        mediaHeight: mediaHeight,
        contactList: ref.read(contactsListProvider),
      );
    },
  );
}

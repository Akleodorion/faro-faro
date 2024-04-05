import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page/sections/members_section/functions/show_message.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showCreateMemberResult(
  BuildContext context,
  CreateMemberState state,
  WidgetRef ref,
  Event event,
) {
  final bool isSucess = state is Loaded && context.mounted;
  final bool isError = state is Error && context.mounted;

  if (isSucess) {
    final fetchEventState = ref.read(fetchEventProvider);
    ref.read(fetchEventProvider.notifier).addMemberToEvent(
          member: state.member,
          fetchEventState: fetchEventState,
          event: event,
        );
    showMessage(context, state.message);
  }

  if (isError) {
    showMessage(context, state.message);
  }
}

import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/delete_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../features/members/presentation/providers/delete_member/state/delete_member_state.dart';

class MemberCard extends ConsumerWidget {
  const MemberCard({
    super.key,
    required this.member,
    required this.event,
  });

  final Member member;
  final Event event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  member.username,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                  // Delete member
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titleTextStyle: const TextStyle(fontSize: 24),
                            contentTextStyle: const TextStyle(fontSize: 16),
                            title: const Text("Ajouter le contact"),
                            content: Text(
                                "Voulez-vous supprimé ${member.userId} à la liste des membres de l'évènement"),
                            actions: [
                              IconButton(
                                onPressed: () async {
                                  final stateResult = await ref
                                      .read(deleteMemberProvider.notifier)
                                      .deleteMember(member: member);
                                  if (context.mounted) {
                                    deleteMember(
                                        context: context,
                                        deleteMemberState: stateResult);
                                  }
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                              )
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 232, 99, 90),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void deleteMember({
    required BuildContext context,
    required DeleteMemberState deleteMemberState,
  }) {
    final bool isSuccess = deleteMemberState is Initial && context.mounted;
    final bool isError = deleteMemberState is Error && context.mounted;

    if (isSuccess) {
      showResultMessageSnackbar(
        context: context,
        message: deleteMemberState.message!,
      );
    }

    if (isError) {
      showResultMessageSnackbar(
        context: context,
        message: deleteMemberState.message,
      );
    }
  }
}

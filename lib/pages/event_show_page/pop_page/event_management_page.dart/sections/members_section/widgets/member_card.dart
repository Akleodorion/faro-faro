import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/delete_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberCard extends ConsumerWidget {
  const MemberCard({
    super.key,
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 150,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Username 1",
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
                                  onPressed: () {
                                    ref
                                        .read(deleteMemberProvider.notifier)
                                        .deleteMember(memberId: member.id);
                                    Navigator.of(context).pop();
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
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
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
            const Text(
              "+2254510203040",
            )
          ],
        ),
      ),
    );
  }
}

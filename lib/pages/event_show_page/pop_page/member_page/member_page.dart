import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/create_member_provider.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/delete_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberPage extends ConsumerWidget {
  const MemberPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberList = event.members;
    final contactList = ref.read(contactsListProvider);
    double rows;
    final mediaHeight = MediaQuery.of(context).size.height;
    if (memberList.length < 3) {
      rows = 0.1;
    } else if (memberList.length >= 3 && memberList.length < 6) {
      rows = 0.2;
    } else {
      rows = 0.3;
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Gestion des membres"),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: (context),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ajouter un membre à l'évènement"),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Contact:"),
                            const SizedBox(
                              height: 2,
                            ),
                            const Divider(
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: mediaHeight * 0.2,
                              child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 2,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                children: [
                                  for (final contact in contactList)
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                titleTextStyle: const TextStyle(
                                                    fontSize: 24),
                                                contentTextStyle:
                                                    const TextStyle(
                                                        fontSize: 16),
                                                title: const Text(
                                                    "Ajouter le contact"),
                                                content: Text(
                                                    "Voulez-vous ajouter ${contact.username} à la liste des membres de l'évènement"),
                                                actions: [
                                                  IconButton(
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                              createMemberProvider
                                                                  .notifier)
                                                          .createMember(
                                                              eventId:
                                                                  event.eventId,
                                                              userId: contact
                                                                  .userId);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                      Icons.done,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.red),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(contact.username),
                                              Text(contact.phoneNumber)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(42, 43, 42, 1),
                Color.fromRGBO(42, 43, 42, 0.2),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text("Membres de l'évènement"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: mediaHeight * rows,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      for (final member in memberList)
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Username 1",
                                    ),
                                    IconButton(
                                        // Delete member
                                        onPressed: () {
                                          ref
                                              .read(
                                                  deleteMemberProvider.notifier)
                                              .deleteMember(
                                                  memberId: member.id);
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 232, 99, 90),
                                        ))
                                  ],
                                ),
                                const Text(
                                  "+2254510203040",
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ));
  }
}

import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilCard extends ConsumerWidget {
  const ProfilCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> userInfo = ref.read(userInfoProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profil",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Email :",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userInfo["email"],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Nom d'utilisateur :",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userInfo["username"],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Numéro de téléphone :",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userInfo["phone_number"],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

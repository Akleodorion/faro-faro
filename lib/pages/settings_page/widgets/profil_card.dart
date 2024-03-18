import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/pages/settings_page/constants/setting_page_strings.dart';
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
              SettingPageStrings.profil,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  SettingPageStrings.email,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 5,
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
                  SettingPageStrings.username,
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
                  SettingPageStrings.phoneNumber,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 5,
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

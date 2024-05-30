// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/pages/settings_page/constants/setting_page_strings.dart';
import 'package:faro_faro/pages/settings_page/widgets/disconnect_button.dart';
import 'package:faro_faro/pages/settings_page/widgets/profil_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    SettingPageStrings.parameters,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ProfilCard(),
                ],
              ),
            ),
          ),
          const DisconnectButton(),
        ],
      ),
    );
  }
}

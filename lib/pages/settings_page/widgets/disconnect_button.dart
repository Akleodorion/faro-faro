// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/user_provider.dart';

class DisconnectButton extends ConsumerWidget {
  const DisconnectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton.icon(
        label: const Text(
          "Déconnexion",
        ),
        onPressed: () async {
          final userState = await ref
              .read(userAuthProvider.notifier)
              .logUserOut(jwt: userInfo["jwt"]);

          if (userState is Unloaded) {
            await ref.read(loggedInProvider.notifier).statusToUnloaded();
          }
        },
        icon: const Icon(
          Icons.logout,
          size: 24,
        ),
      ),
    );
  }
}

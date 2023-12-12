import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () async {
          await ref
              .read(userAuthProvider.notifier)
              .logUserOut(jwt: userInfo["jwt"]);
        },
        icon: const Icon(
          Icons.logout,
          size: 24,
        ),
      ),
    );
  }
}

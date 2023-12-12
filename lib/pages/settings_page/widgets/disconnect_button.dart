import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisconnectButton extends ConsumerWidget {
  const DisconnectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton.icon(
        label: const Text(
          "Déconnexion",
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
          size: 24,
        ),
      ),
    );
  }
}

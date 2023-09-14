import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpperRow extends ConsumerWidget {
  const UpperRow({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String username;
    final userState = ref.read(userAuthProvider);
    if (userState is Loaded) {
      username = userState.user.username;
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi $username",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Wanna hang out ?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        )
      ],
    );
  }
}

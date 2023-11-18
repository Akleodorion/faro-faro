import '../../../../../core/util/capitalize_first_letter.dart';
import '../../../../../features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoDisplay extends ConsumerWidget {
  const UserInfoDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // initialisations des  variables
    final username = CapitalizeFirstLetterImpl()
        .capitalizeInput(ref.read(userInfoProvider)["username"]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}

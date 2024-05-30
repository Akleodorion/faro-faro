// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/pages/home_page/constants/home_page_strings.dart';
import '../../../../../core/util/capitalize_first_letter.dart';

class UserInfoDisplay extends ConsumerWidget {
  const UserInfoDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = CapitalizeFirstLetterImpl()
        .capitalizeInput(ref.read(userInfoProvider)["username"]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${HomePageStrings.greetings}$username",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          HomePageStrings.catchPhrase,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/constants/constants.dart';

class RememberCheckbox extends StatefulWidget {
  const RememberCheckbox({super.key, required this.isChecked});
  final bool isChecked;

  @override
  State<RememberCheckbox> createState() => _RememberCheckboxState();
}

class _RememberCheckboxState extends State<RememberCheckbox> {
  bool? _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(builder: (context, ref, child) {
          return Checkbox(
            value: _isChecked ?? false,
            onChanged: (value) {
              final state = ref.read(loggedInProvider);
              if (state is Unloaded) {
                ref
                    .read(loggedInProvider.notifier)
                    .togglePref(state.userInfo, value!);
              }
              setState(() {
                _isChecked = value!;
              });
            },
          );
        }),
        const SizedBox(width: 10),
        Text(
          Strings.rememberMe,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 12),
        )
      ],
    );
  }
}

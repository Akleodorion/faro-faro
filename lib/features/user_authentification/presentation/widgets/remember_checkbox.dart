import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              final state = ref.read(userAuthProvider);
              if (state is Initial) {
                ref
                    .read(userAuthProvider.notifier)
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

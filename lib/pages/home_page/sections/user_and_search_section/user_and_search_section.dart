// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'widgets/user_info_display.dart';

class UserAndSearchSection extends StatelessWidget {
  const UserAndSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoDisplay(),
        ],
      ),
    );
  }
}

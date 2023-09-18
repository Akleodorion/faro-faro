import 'widgets/search_button.dart';
import 'widgets/user_info_display.dart';
import 'package:flutter/material.dart';

class UserAndSearchSection extends StatelessWidget {
  const UserAndSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: (screenHeight) * 0.05,
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoDisplay(),
          SearchButton(),
        ],
      ),
    );
  }
}

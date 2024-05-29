import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleAndNavigationSection extends StatelessWidget {
  const TitleAndNavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReturnButton(mediaWidth: mediaWidth),
        const MainTitle(),
        Container(
          width: mediaWidth * 0.1,
        ),
      ],
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Créer un nouvel évènement",
          style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

// Widget du bouton de retour

class ReturnButton extends ConsumerWidget {
  const ReturnButton({
    super.key,
    required this.mediaWidth,
  });

  final double mediaWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.centerLeft,
      width: mediaWidth * 0.1,
      child: IconButton(
        onPressed: () {
          ref.read(postEventProvider.notifier).reset(null);
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }
}

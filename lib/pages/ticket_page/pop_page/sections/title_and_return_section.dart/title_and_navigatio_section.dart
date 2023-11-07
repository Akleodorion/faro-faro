import 'package:flutter/material.dart';

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

// Titre de la page

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Créer un nouvel évènement",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground)),
    );
  }
}

// Widget du bouton de retour

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
    required this.mediaWidth,
  });

  final double mediaWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: mediaWidth * 0.1,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}

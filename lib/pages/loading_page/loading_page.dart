import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(42, 43, 42, 1),
            Color.fromRGBO(42, 43, 42, 0.2),
          ],
        )),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

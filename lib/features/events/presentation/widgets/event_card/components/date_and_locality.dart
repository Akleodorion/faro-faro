import 'package:flutter/material.dart';

class DateAndLocality extends StatelessWidget {
  const DateAndLocality(
      {super.key, required this.formatedDate, required this.formatedAddress});

  final String formatedDate;
  final String formatedAddress;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$formatedDate - $formatedAddress",
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

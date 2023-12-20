import 'package:flutter/material.dart';

class SizeInfo {
  final BuildContext context;

  SizeInfo({required this.context});

  double get height {
    return MediaQuery.sizeOf(context).height;
  }

  double get width {
    return MediaQuery.sizeOf(context).width;
  }
}

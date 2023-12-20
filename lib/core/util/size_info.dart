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

  bool isScreenSizeMini() {
    return MediaQuery.of(context).size.width < 350 &&
        MediaQuery.of(context).size.height < 600;
  }

  bool isScreenSizeStandard() {
    return MediaQuery.of(context).size.width > 350 &&
        MediaQuery.of(context).size.height < 700;
  }

  bool isScreenSizeLarge() {
    return MediaQuery.of(context).size.width > 350 &&
        MediaQuery.of(context).size.height > 700;
  }
}

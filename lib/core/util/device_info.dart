import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:flutter/material.dart';

enum ScreenHeight {
  smallHeight,
  standardHeight,
  largeHeight,
}

enum ScreenWidth {
  smallWidth,
  standardWidth,
  largeWidth,
}

class DeviceInfo {
  ScreenHeight getScreenHeight(BuildContext context) {
    final mediaHeight = MediaQuery.sizeOf(context).height;
    final bool isScreenHeightSmall = mediaHeight < 580;
    final bool isScreenHeightStandard = mediaHeight >= 580 && mediaHeight < 700;
    final bool isScreenHeightLarge = mediaHeight >= 700;

    if (isScreenHeightLarge) {
      return ScreenHeight.largeHeight;
    }

    if (isScreenHeightStandard) {
      return ScreenHeight.standardHeight;
    }

    if (isScreenHeightSmall) {
      return ScreenHeight.smallHeight;
    }
    throw ServerException(errorMessage: 'an error occured');
  }

  ScreenWidth getScreenWidth(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final bool isScreenWidthSmall = mediaWidth < 350;
    final bool isScreenWidthStandard = mediaWidth >= 350 && mediaWidth < 415;
    final bool isScreenWidthLarge = mediaWidth >= 415;

    if (isScreenWidthLarge) {
      return ScreenWidth.largeWidth;
    }

    if (isScreenWidthStandard) {
      return ScreenWidth.standardWidth;
    }

    if (isScreenWidthSmall) {
      return ScreenWidth.smallWidth;
    }
    throw ServerException(errorMessage: 'an error occured');
  }
}

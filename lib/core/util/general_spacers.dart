// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/device_info.dart';

class GeneralSpacers {
  double getBlocSeparation(BuildContext context) {
    final screenHeight = DeviceInfo().getScreenHeight(context);
    if (screenHeight == ScreenHeight.smallHeight) {
      return 10;
    }
    if (screenHeight == ScreenHeight.standardHeight) {
      return 15;
    }
    if (screenHeight == ScreenHeight.largeHeight) {
      return 20;
    }

    throw ServerException(errorMessage: 'an error as occured');
  }

  double getTitleSpace(BuildContext context) {
    final screenHeight = DeviceInfo().getScreenHeight(context);
    if (screenHeight == ScreenHeight.smallHeight) {
      return 5;
    }
    if (screenHeight == ScreenHeight.standardHeight) {
      return 7;
    }
    if (screenHeight == ScreenHeight.largeHeight) {
      return 9;
    }
    throw ServerException(errorMessage: 'an error as occured');
  }

  double getMainColumnPadding(BuildContext context) {
    final screenHeight = DeviceInfo().getScreenHeight(context);
    if (screenHeight == ScreenHeight.smallHeight) {
      return 10;
    }
    if (screenHeight == ScreenHeight.standardHeight) {
      return 15;
    }
    if (screenHeight == ScreenHeight.largeHeight) {
      return 20;
    }
    throw ServerException(errorMessage: 'an error as occured');
  }
}

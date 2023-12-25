import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/device_info.dart';
import 'package:flutter/material.dart';

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

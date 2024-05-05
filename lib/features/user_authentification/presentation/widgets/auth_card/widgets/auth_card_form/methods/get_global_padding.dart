import 'package:faro_clean_tdd/core/util/size_info.dart';
import 'package:flutter/widgets.dart';

double getGlobalPadding(BuildContext context) {
  final bool isScreenSizeMini = SizeInfo(context: context).isScreenSizeMini();
  final bool isScreenSizeStandard =
      SizeInfo(context: context).isScreenSizeStandard();

  if (isScreenSizeMini) {
    return 20;
  } else if (isScreenSizeStandard) {
    return 35;
  } else {
    return 45;
  }
}

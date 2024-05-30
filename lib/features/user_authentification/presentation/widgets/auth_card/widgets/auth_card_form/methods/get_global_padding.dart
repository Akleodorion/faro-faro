// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:faro_faro/core/util/size_info.dart';

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

// Package imports:
import 'package:intl/intl.dart';

abstract class NumberFormatter {
  String formatNumber(int number);
}

class NumberFormatterImpl implements NumberFormatter {
  @override
  String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'fr_FR');
    return formatter.format(number);
  }
}

import 'package:intl/intl.dart';

abstract class DateFormatValidator {
  bool isValidDateFormat(String inputDate, String dateFormat);
}

class DateFormatValidatorImpl implements DateFormatValidator {
  @override
  bool isValidDateFormat(String inputDate, String dateFormat) {
    try {
      DateFormat(dateFormat, 'fr').parseStrict(inputDate);
      return true;
    } catch (e) {
      return false;
    }
  }
}

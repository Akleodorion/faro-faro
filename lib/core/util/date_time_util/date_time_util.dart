abstract class DateTimeUtil {
  bool isDateTimeDifferenceInMinuteValid({
    required DateTime first,
    required DateTime second,
    required int minutesTreshold,
  });
}

class DateTimeUtilImpl implements DateTimeUtil {
  @override
  bool isDateTimeDifferenceInMinuteValid(
      {required DateTime first,
      required DateTime second,
      required int minutesTreshold}) {
    final int difference = first.difference(second).inMinutes;
    return difference < 60;
  }
}

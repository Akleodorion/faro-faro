abstract class DateTimeComparator {
  bool isValid(DateTime dateTime);
}

class DateTimeComparatorImpl implements DateTimeComparator {
  @override
  bool isValid(DateTime dateTime) {
    final difference = dateTime.difference(DateTime.now()).inMinutes;
    if (difference < 60) {
      return true;
    } else {
      return false;
    }
  }
}

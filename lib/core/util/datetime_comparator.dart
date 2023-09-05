abstract class DateTimeComparator {
  bool isValid(DateTime dateTime);
}

class DateTimeComparatorImpl implements DateTimeComparator {
  @override
  bool isValid(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime).inMinutes;
    if (difference < 60) {
      return true;
    } else {
      return false;
    }
  }
}

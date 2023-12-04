abstract class PhoneNumberValidator {
  String parseNumber(String phoneNumber);
}

class PhoneNumberValidatorImpl implements PhoneNumberValidator {
  @override
  String parseNumber(String phoneNumber) {
    final number = phoneNumber.trim().split('');
    if (number[4] == '0') {
      number.removeAt(4);
      return number.join();
    } else {
      return number.join();
    }
  }
}

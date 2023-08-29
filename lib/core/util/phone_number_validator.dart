abstract class PhoneNumberValidator {
  String? phoneNumberValidator(String phoneNumber);
  String parseNumber(String phoneNumber);
}

class PhoneNumberValidatorImpl implements PhoneNumberValidator {
  @override
  String? phoneNumberValidator(String phoneNumber) {
    final newPhoneNumber = phoneNumber.replaceAll(' ', '');
    RegExp regex1 = RegExp(r'^0\d{7,9}$');
    RegExp regex2 = RegExp(r'^(?!0)\d{7}(\d{2})?$|^(?!0)\d{9}$');

    if ((regex1.hasMatch(newPhoneNumber) || regex2.hasMatch(newPhoneNumber)) &&
        phoneNumber.isNotEmpty) {
      return null;
    } else {
      return 'Numéro invalide';
    }
  }

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

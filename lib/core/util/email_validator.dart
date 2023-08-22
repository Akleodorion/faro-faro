import 'package:email_validator/email_validator.dart';

abstract class EmailValidation {
  String? isEmailValid(String email);
}

class EmailValidationImpl implements EmailValidation {
  @override
  String? isEmailValid(String email) {
    final RegExp regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (EmailValidator.validate(email) && regexp.hasMatch(email)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }
}

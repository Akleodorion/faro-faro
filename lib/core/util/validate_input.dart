// Cette classe va nous permettre de gérer l'ensemble des validations que nous devons faire au travers de l'application.
import 'package:email_validator/email_validator.dart';

abstract class ValidateInput {
  String? passwordValidator(String password);
  String? isEmailValid(String email);
}

class ValidateInputImpl implements ValidateInput {
  @override
  String? passwordValidator(String password) {
    if (password.trim() == '' || password.trim().length < 6) {
      return 'Enter a valid password min 6 chars.';
    }
    return null;
  }

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

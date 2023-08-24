abstract class PasswordValidator {
  String? passwordValidator(String password);
}

class PasswordValidatorImpl implements PasswordValidator {
  @override
  String? passwordValidator(String password) {
    if (password.trim() == '' || password.trim().length < 6) {
      return 'Enter a valid password min 6 chars.';
    }
    return null;
  }
}

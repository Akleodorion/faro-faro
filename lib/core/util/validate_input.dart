// Cette classe va nous permettre de gérer l'ensemble des validations que nous devons faire au travers de l'application.

abstract class ValidateInput {
  String? passwordValidator(String password);
}

class ValidateInputImpl implements ValidateInput {
  @override
  String? passwordValidator(String password) {
    if (password.trim() == '' || password.trim().length < 6) {
      return 'Enter a valid password min 6 chars.';
    }
    return null;
  }
}

// Cette classe va nous permettre de gérer l'ensemble des validations que nous devons faire au travers de l'application.
import 'package:email_validator/email_validator.dart';

abstract class ValidateInput {
  String? passwordValidator(String? password);
  String? isEmailValid(String? email);
  String? phoneNumberValidator(String? phoneNumber);
  String? eventDescriptionValidator(String? eventDescription);
  String? positiveNumberInputValidator(String? numberInput);
  String? eventTitleValidator(String? titleInput);
}

class ValidateInputImpl implements ValidateInput {
  final int passwordMinLength = 6;
  final int eventDescriptionMinLength = 50;
  final int eventDescriptionMaxLength = 600;
  final int eventTitleMinLength = 10;
  final int eventTitleMaxLength = 40;

  @override
  String? passwordValidator(String? password) {
    if (password == null) {
      return "Can't be blank";
    } else if (password.trim() == '' ||
        password.trim().length < passwordMinLength) {
      return 'Enter a valid password min 6 chars.';
    }
    return null;
  }

  @override
  String? isEmailValid(String? email) {
    final RegExp regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email == null) {
      return "Can't be blank";
    }
    if (EmailValidator.validate(email) && regexp.hasMatch(email)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }

  @override
  String? phoneNumberValidator(String? phoneNumber) {
    RegExp regex1 = RegExp(r'^0\d{7,9}$');
    RegExp regex2 = RegExp(r'^(?!0)\d{7}(\d{2})?$|^(?!0)\d{9}$');

    if (phoneNumber == null) {
      return "Can't be blank";
    }
    final newPhoneNumber = phoneNumber.replaceAll(' ', '');
    if ((regex1.hasMatch(newPhoneNumber) || regex2.hasMatch(newPhoneNumber))) {
      return null;
    } else {
      return 'Numéro invalide';
    }
  }

  @override
  String? eventDescriptionValidator(String? eventDescription) {
    if (eventDescription == null || eventDescription.isEmpty) {
      return "Field can't be blank";
    } else if (eventDescription.length < eventDescriptionMinLength) {
      return 'La description doit avoir un minimum de $eventDescriptionMinLength caractères';
    } else if (eventDescription.length > eventDescriptionMaxLength) {
      return 'La description doit avoir un maximum de $eventDescriptionMaxLength caractères';
    }
    return null;
  }

  @override
  String? positiveNumberInputValidator(String? numberInput) {
    if (numberInput == null) {
      return 'Champ vide';
    }
    final parsedNumber = int.tryParse(numberInput);

    if (parsedNumber == null) {
      return 'Entrez un nombre';
    } else if (parsedNumber < 0) {
      return 'Nombre invalide';
    } else {
      return null;
    }
  }

  @override
  String? eventTitleValidator(String? titleInput) {
    if (titleInput == null || titleInput.isEmpty) {
      return "Can't be blank";
    } else if (titleInput.length < eventTitleMinLength) {
      return "Le titre doit avoir un minimum de $eventTitleMinLength caractères";
    } else if (titleInput.length > eventTitleMaxLength) {
      return "Le titre doit avoir un maximum de $eventTitleMaxLength caractères";
    }

    return null;
  }
}

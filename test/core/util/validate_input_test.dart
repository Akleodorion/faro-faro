// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/core/util/validate_input.dart';

void main() {
  late ValidateInputImpl sut;

  setUp(() {
    sut = ValidateInputImpl();
  });

  group(
    "passwordValidator",
    () {
      const String tPassword1 = '        ';
      const String tPassword2 = 'xyz';
      const String tPassword3 = '1234567';
      test(
        "should return a string if the entered value is no min 6 chars long.",
        () async {
          //act
          final result1 = sut.passwordValidator(tPassword1);
          final result2 = sut.passwordValidator(tPassword2);
          //assert
          expect(result1, 'Enter a valid password min 6 chars.');
          expect(result2, 'Enter a valid password min 6 chars.');
        },
      );

      test(
        "should return null if the password is longer than 6 chars.",
        () async {
          //act
          final result = sut.passwordValidator(tPassword3);
          //assert
          expect(result, null);
        },
      );
    },
  );

  group(
    "isEmailValid",
    () {
      test(
        "should return error if no value entered",
        () async {
          //act
          final result = sut.isEmailValid('');
          //assert
          expect(result, 'Please enter a valid email');
        },
      );

      test(
        "should return error if uncorrect email entered",
        () async {
          final tEmail = [
            'chris.com',
            'chris@gmail.com.',
            "chris@gmail@.com",
            "chris*@gmail.com"
          ];
          //act
          final result1 = sut.isEmailValid(tEmail[0]);
          final result2 = sut.isEmailValid(tEmail[1]);
          final result3 = sut.isEmailValid(tEmail[2]);
          final result4 = sut.isEmailValid(tEmail[3]);
          //assert
          expect(result1, 'Please enter a valid email');
          expect(result2, 'Please enter a valid email');
          expect(result3, 'Please enter a valid email');
          expect(result4, 'Please enter a valid email');
        },
      );

      test(
        "should return void if email is valid",
        () async {
          final tEmail = [
            'chris.59@hotmail.com',
            'chris-bondzie@yahoo.co.uk',
            "chris@gmail.com",
          ];
          //act
          final result1 = sut.isEmailValid(tEmail[0]);
          final result2 = sut.isEmailValid(tEmail[1]);
          final result3 = sut.isEmailValid(tEmail[2]);
          //assert
          expect(result1, null);
          expect(result2, null);
          expect(result3, null);
        },
      );
    },
  );

  group(
    "phoneNumberValidator",
    () {
      final List<String> tPhoneNumbers = [
        '01 20 30 40 50',
        '0102030405',
        '08 20 30 40'
      ];

      final List<String> tPhoneWrongNumbers = [
        '20 30 40 50',
        '+2250850406080',
        '+08 20 30 40'
      ];
      test(
        "should return null if the phone number is correct",
        () async {
          //act

          final result1 = sut.phoneNumberValidator(tPhoneNumbers[0]);
          final result2 = sut.phoneNumberValidator(tPhoneNumbers[1]);
          final result3 = sut.phoneNumberValidator(tPhoneNumbers[2]);
          //assert
          expect(result1, null);
          expect(result2, null);
          expect(result3, null);
        },
      );

      test(
        "should return Numéro invalide if the phone number is uncorrect",
        () async {
          //act

          final result1 = sut.phoneNumberValidator(tPhoneWrongNumbers[0]);
          final result2 = sut.phoneNumberValidator(tPhoneWrongNumbers[1]);
          final result3 = sut.phoneNumberValidator(tPhoneWrongNumbers[2]);
          //assert
          expect(result1, 'Numéro invalide');
          expect(result2, 'Numéro invalide');
          expect(result3, 'Numéro invalide');
        },
      );
    },
  );

  group(
    "eventDescriptionValidator",
    () {
      const List<String?> tDescriptions = [
        null,
        "short description",
        "Good description too give an event too expected to be that long is good tho,Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description too give an event too expected to be that long is good tho.Good description toogive an event too expected to be that long is good tho.,Good description too give an event too expected to be that long is good tho.,Good description too give an event too expected to be that long is good tho.,Good description too give an event too expected to be that long is good tho.",
        "Good description too give an event too expected to be that long is good tho,Good description too give an event too expected to be that long is good tho."
      ];
      test(
        "should return can't be blank if no description given.",
        () async {
          //act
          final result = sut.eventDescriptionValidator(tDescriptions[0]);
          //assert
          expect(result, "Field can't be blank");
        },
      );

      test(
        "should return the min chars if description is too short",
        () async {
          //act
          final result = sut.eventDescriptionValidator(tDescriptions[1]);
          //assert
          expect(result,
              'La description doit avoir un minimum de ${sut.eventDescriptionMinLength} caractères');
        },
      );

      test(
        "should return the min chars if description is too long",
        () async {
          //act
          final result = sut.eventDescriptionValidator(tDescriptions[2]);
          //assert
          expect(result,
              'La description doit avoir un maximum de ${sut.eventDescriptionMaxLength} caractères');
        },
      );
      test(
        "should return null if the description is valid",
        () async {
          //act
          final result = sut.eventDescriptionValidator(tDescriptions[3]);
          //assert
          expect(result, null);
        },
      );
    },
  );

  group(
    "positiveNumberInputValidator",
    () {
      final List<String?> tNumberInput = [
        null,
        'xyz2',
        '12.4',
        '-4',
        '0',
        '12',
      ];

      test(
        "should return can't be blank when no value entered",
        () async {
          //act
          final result = sut.positiveNumberInputValidator(tNumberInput[0]);
          //assert
          expect(result, 'Champ vide');
        },
      );
      test(
        "should return Entrez un nombre if not a number",
        () async {
          //act
          final result1 = sut.positiveNumberInputValidator(tNumberInput[1]);
          final result2 = sut.positiveNumberInputValidator(tNumberInput[2]);
          //assert
          expect(result1, 'Entrez un nombre');
          expect(result2, 'Entrez un nombre');
        },
      );

      test(
        "should return nombre invalide if value negative.",
        () async {
          //act
          final result = sut.positiveNumberInputValidator(tNumberInput[3]);
          //assert
          expect(result, 'Nombre invalide');
        },
      );

      test(
        "should return null if the value is an positive int 0 incl.",
        () async {
          //act
          final result1 = sut.positiveNumberInputValidator(tNumberInput[4]);
          final result2 = sut.positiveNumberInputValidator(tNumberInput[5]);
          //assert
          expect(result1, null);
          expect(result2, null);
        },
      );
    },
  );

  group(
    "eventTitleValidator",
    () {
      final List<String?> tTitles = [
        null,
        '',
        's-title',
        "Too long title for a event even if it's a test here",
        "Good event title"
      ];
      test(
        "should return can't be blank if value is null",
        () async {
          //act
          final result = sut.eventTitleValidator(tTitles[0]);
          //assert
          expect(result, "Can't be blank");
        },
      );

      test(
        "should return can't be blank if value is empty",
        () async {
          //act
          final result = sut.eventTitleValidator(tTitles[1]);
          //assert
          expect(result, "Can't be blank");
        },
      );

      test(
        "should return title is too short if the value is less than min chars",
        () async {
          //act
          final result = sut.eventTitleValidator(tTitles[2]);
          //assert
          expect(result,
              "Le titre doit avoir un minimum de ${sut.eventTitleMinLength} caractères");
        },
      );

      test(
        "should return title is too long if the value is more than max chars",
        () async {
          //act
          final result = sut.eventTitleValidator(tTitles[3]);
          //assert
          expect(result,
              "Le titre doit avoir un maximum de ${sut.eventTitleMaxLength} caractères");
        },
      );

      test(
        "should return null if title valid",
        () async {
          //act
          final result = sut.eventTitleValidator(tTitles[4]);
          //assert
          expect(result, null);
        },
      );
    },
  );
}

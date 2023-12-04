import 'package:faro_clean_tdd/core/util/validate_input.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

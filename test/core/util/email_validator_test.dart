import 'package:faro_clean_tdd/core/util/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EmailValidationImpl emailValidationImpl;

  setUp(() {
    emailValidationImpl = EmailValidationImpl();
  });

  group(
    "EmailValidationImpl",
    () {
      test(
        "should return error if no value entered",
        () async {
          //act
          final result = emailValidationImpl.isEmailValid('');
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
          final result1 = emailValidationImpl.isEmailValid(tEmail[0]);
          final result2 = emailValidationImpl.isEmailValid(tEmail[1]);
          final result3 = emailValidationImpl.isEmailValid(tEmail[2]);
          final result4 = emailValidationImpl.isEmailValid(tEmail[3]);
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
          final result1 = emailValidationImpl.isEmailValid(tEmail[0]);
          final result2 = emailValidationImpl.isEmailValid(tEmail[1]);
          final result3 = emailValidationImpl.isEmailValid(tEmail[2]);
          //assert
          expect(result1, null);
          expect(result2, null);
          expect(result3, null);
        },
      );
    },
  );
}

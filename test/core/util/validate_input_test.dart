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
}

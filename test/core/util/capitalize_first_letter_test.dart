// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/core/util/capitalize_first_letter.dart';

void main() {
  late CapitalizeFirstLetterImpl capitalizeFirstLetterImpl;

  setUp(() => capitalizeFirstLetterImpl = CapitalizeFirstLetterImpl());

  const tInput = "akleo";
  test(
    "should return the input with the first letter capitalized",
    () async {
      //act
      final result = capitalizeFirstLetterImpl.capitalizeInput(tInput);
      //assert

      const expected = "Akleo";
      expect(result, expected);
    },
  );
}

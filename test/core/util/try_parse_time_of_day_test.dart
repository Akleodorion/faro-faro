// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/core/util/try_parse_time_of_day.dart';

void main() {
  late TryParseTimeOfDayImpl tryParseTimeOfDayImpl;

  setUp(() => tryParseTimeOfDayImpl = TryParseTimeOfDayImpl());

  group("tryParseTimeOfDay", () {
    const tCorrectString = "18:00";
    const tWrongString = "char";
    test(
      "should return a valid dateTime when the string is a correct Time.",
      () async {
        //arrange
        const TimeOfDay expectedResult = TimeOfDay(hour: 18, minute: 0);
        //act
        final result = tryParseTimeOfDayImpl.tryParseTimeOfDay(
            stringToParse: tCorrectString);
        //assert
        expect(result, expectedResult);
      },
    );

    test(
      "should return null  when the string is a wrong Time.",
      () async {
        //arrange
        //act
        final result = tryParseTimeOfDayImpl.tryParseTimeOfDay(
            stringToParse: tWrongString);
        //assert
        expect(result, null);
      },
    );
  });

  group("getString", () {
    const TimeOfDay tTime = TimeOfDay(hour: 18, minute: 00);
    test(
      "should return a correct formated date time string",
      () async {
        //arrange
        const String expectedResult = "18:00";
        //act
        final result = tryParseTimeOfDayImpl.getString(timeToParse: tTime);
        //assert
        expect(result, expectedResult);
      },
    );
  });
}

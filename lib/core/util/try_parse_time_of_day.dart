import 'package:flutter/material.dart';

abstract class TryParseTimeOfDay {
  TimeOfDay? tryParseTimeOfDay({required String stringToParse});
  String? getString({required TimeOfDay timeToParse});
}

class TryParseTimeOfDayImpl implements TryParseTimeOfDay {
  @override
  TimeOfDay? tryParseTimeOfDay({required String stringToParse}) {
    try {
      List<String> parts = stringToParse.split(':');
      if (parts.length == 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60) {
          return TimeOfDay(hour: hour, minute: minute);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  String? getString({required TimeOfDay timeToParse}) {
    String hour = timeToParse.hour.toString();
    String minute = timeToParse.minute.toString();

    if (timeToParse.hour.toString().length == 1) {
      hour = "0${timeToParse.hour}";
    }
    if (timeToParse.minute.toString().length == 1) {
      minute = "0${timeToParse.minute}";
    }

    return "$hour:$minute";
  }
}

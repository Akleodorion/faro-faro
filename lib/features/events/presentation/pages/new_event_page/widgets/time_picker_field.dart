// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/util/try_parse_time_of_day.dart';
import 'package:faro_faro/core/util/validate_input.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField(
      {super.key, required this.setValue, required this.startOrEndTime});

  final void Function(TimeOfDay timeOfDay) setValue;
  final String startOrEndTime;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  final TextEditingController _timeController = TextEditingController();
  bool hasError = false;
  double minHeight = 70.0;
  double maxHeight = 90.0;

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    // ignore: no_leading_underscores_for_local_identifiers
    Future<TimeOfDay?> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      return pickedTime;
    }

    return Container(
      width: (mediaWidth - 40) * 0.30,
      height: hasError ? maxHeight : minHeight,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          readOnly: true,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            label: Text(
              widget.startOrEndTime == "start_time" ? "Start at :" : "End at :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          validator: (value) {
            setState(() => hasError = false);
            final result = ValidateInputImpl().isValidTimeFormat(value);
            result != null ? setState(() => hasError = true) : null;
            return result;
          },
          controller: _timeController,
          onTap: () async {
            final TimeOfDay? selectedTime = await _selectTime(context);
            if (selectedTime != null) {
              setState(() {
                _timeController.text = TryParseTimeOfDayImpl()
                        .getString(timeToParse: selectedTime) ??
                    '';
              });
            }
          },
          onSaved: (value) {
            final TimeOfDay timeOfDay = TryParseTimeOfDayImpl()
                    .tryParseTimeOfDay(stringToParse: value!) ??
                const TimeOfDay(hour: 00, minute: 00);
            widget.setValue(timeOfDay);
          },
        ),
      ),
    );
  }
}

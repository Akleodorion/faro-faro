import 'package:faro_clean_tdd/core/util/date_format_validator.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField(
      {super.key, required this.initialValue, required this.setValue});

  final String initialValue;
  final void Function(DateTime) setValue;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  bool hasError = false;
  double minHeight = 70.0;
  double maxHeight = 90.0;
  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (mediaWidth - 40) * 0.30,
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text(
              "Date :",
              style: TextStyle(fontSize: 14),
            ),
          ),
          validator: (value) {
            setState(() {
              hasError = false;
            });
            if (!DateFormatValidatorImpl()
                .isValidDateFormat(value!, 'dd/MM/yyyy')) {
              setState(() {
                hasError = true;
              });
              return 'Date invalide';
            }
            return null;
          },
          initialValue: widget.initialValue,
          onTap: () async {
            // pick a date
            final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate:
                    DateTime.now().copyWith(year: DateTime.now().year + 1));
            // if no value selected nothing is done.
            if (pickedDate == null) {
              return;
            }
            // Change the value of the selectedDate
            widget.setValue(pickedDate);
          },
          keyboardType: null,
        ),
      ),
    );
  }
}

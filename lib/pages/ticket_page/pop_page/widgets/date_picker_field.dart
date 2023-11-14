import 'package:faro_clean_tdd/core/util/date_format_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.onSave,
  });

  final void Function(String value) onSave;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    double minHeight = 70.0;
    double maxHeight = 90.0;
    final double mediaWidth = MediaQuery.of(context).size.width;

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null && pickedDate != _selectedDate) {
        setState(() {
          _selectedDate = pickedDate;
          _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        });
      }
    }

    return Container(
      width: (mediaWidth - 40) * 0.30,
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
            label: Text(
              "Date :",
              style: TextStyle(fontSize: 14),
            ),
          ),
          validator: (value) {
            setState(() {
              hasError = !DateFormatValidatorImpl()
                  .isValidDateFormat(value!, 'dd/MM/yyyy');
            });
            return hasError ? 'Date invalide' : null;
          },
          controller: _dateController,
          onTap: () => _selectDate(context),
          onSaved: (value) {
            widget.onSave(value!);
          },
        ),
      ),
    );
  }
}

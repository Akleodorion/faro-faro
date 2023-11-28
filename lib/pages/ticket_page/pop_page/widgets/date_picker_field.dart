import 'package:faro_clean_tdd/core/util/date_format_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key, required this.setValue});

  final void Function(DateTime) setValue;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _dateController = TextEditingController();
  bool hasError = false;
  double minHeight = 70.0;
  double maxHeight = 90.0;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    // ignore: no_leading_underscores_for_local_identifiers
    Future<DateTime?> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      return pickedDate;
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
          onTap: () async {
            final DateTime? selectedDate = await _selectDate(context);
            if (selectedDate != null) {
              setState(() {
                _dateController.text =
                    DateFormat('dd/MM/yyyy').format(selectedDate);
              });
            }
          },
          onSaved: (value) {
            widget.setValue(DateFormat('dd/MM/yyyy').parse(value!));
          },
        ),
      ),
    );
  }
}

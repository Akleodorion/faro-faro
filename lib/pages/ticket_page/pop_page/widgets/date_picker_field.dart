import 'package:faro_clean_tdd/core/util/date_format_validator.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DatePickerField extends ConsumerStatefulWidget {
  const DatePickerField({super.key});

  @override
  ConsumerState<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends ConsumerState<DatePickerField> {
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dateController.text = DateFormat('dd/MM/yyyy')
          .format(ref.watch(postEventMapProvider)["date"]);
    });

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
          onEditingComplete: () {
            ref.read(postEventProvider.notifier).updateKey(
                'date', DateFormat('dd/MM/yyyy').parse(_dateController.text));
          },
          onTap: () async {
            final DateTime? selectedDate = await _selectDate(context);

            if (selectedDate != null) {
              ref
                  .read(postEventProvider.notifier)
                  .updateKey('date', selectedDate);
            }
          },
          onSaved: (value) {
            ref
                .read(postEventProvider.notifier)
                .updateKey('date', DateFormat('dd/MM/yyyy').parse(value!));
          },
        ),
      ),
    );
  }
}

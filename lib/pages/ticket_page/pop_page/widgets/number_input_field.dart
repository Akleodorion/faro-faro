import 'package:flutter/material.dart';

class NumberInputField extends StatefulWidget {
  const NumberInputField({super.key, required this.trailingText});

  final String trailingText;

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  int inputValue = 0;
  bool hasError = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = inputValue.toString();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.trailingText,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
              boxShadow: kElevationToShadow[3],
              color: Theme.of(context).colorScheme.surface),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (inputValue > 0) {
                        inputValue = inputValue - 1;
                      } else {
                        return;
                      }
                      textEditingController.text = inputValue.toString();
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background),
                width: hasError ? maxWidth * 0.30 : maxWidth * 0.15,
                child: TextFormField(
                  controller: textEditingController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    setState(() {
                      hasError = false;
                    });
                    // transformation du nombre en nombre positif
                    final int? intValue = int.tryParse(value!);
                    if (intValue == null || intValue < 0) {
                      setState(() {
                        hasError = true;
                      });

                      return 'Nombre invalide';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    inputValue = inputValue + 1;
                    textEditingController.text = inputValue.toString();
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

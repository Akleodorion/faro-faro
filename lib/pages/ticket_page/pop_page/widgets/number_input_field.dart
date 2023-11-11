import 'package:flutter/material.dart';

class NumberInputField extends StatefulWidget {
  const NumberInputField(
      {super.key, required this.trailingText, required this.isQuantity});

  final String trailingText;
  final bool isQuantity;

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
          height: 5,
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
                    final int calculus =
                        inputValue - (widget.isQuantity == true ? 1 : 1000);
                    if (calculus < 0) {
                      setState(() {
                        inputValue = 0;
                        textEditingController.text = inputValue.toString();
                      });
                    } else {
                      setState(() {
                        inputValue =
                            inputValue - (widget.isQuantity == true ? 1 : 1000);

                        textEditingController.text = inputValue.toString();
                      });
                    }
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
                  onChanged: (value) {
                    final int? intValue = int.tryParse(value);
                    if (intValue != null && intValue >= 0) {
                      setState(() {
                        inputValue = intValue;
                      });
                    }
                  },
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
                  final int calculus =
                      inputValue + (widget.isQuantity == true ? 1 : 1000);
                  if (calculus < 0) {
                    setState(() {
                      inputValue = calculus;
                      textEditingController.text = inputValue.toString();
                    });
                  } else {
                    setState(() {
                      inputValue =
                          inputValue + (widget.isQuantity == true ? 1 : 1000);

                      textEditingController.text = inputValue.toString();
                    });
                  }
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

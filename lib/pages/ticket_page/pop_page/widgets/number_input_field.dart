import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberInputField extends ConsumerStatefulWidget {
  const NumberInputField(
      {super.key,
      required this.trailingText,
      required this.isQuantity,
      required this.mapKey,
      required this.setValue});

  final String trailingText;
  final bool isQuantity;
  final String mapKey;
  final void Function(int value) setValue;

  @override
  ConsumerState<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends ConsumerState<NumberInputField> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = '0';
  }

  @override
  void dispose() {
    textEditingController.dispose();
    inputFocusNode.dispose();
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
                    incrOrDecrNumber(false);
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
                  focusNode: inputFocusNode,
                  keyboardType: TextInputType.number,
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
                  onSaved: (value) {
                    widget.setValue(int.tryParse(value!)!);
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  incrOrDecrNumber(true);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void incrOrDecrNumber(bool isIncrement) {
    final int operation = isIncrement ? 1 : -1;
    final int calculus = int.tryParse(textEditingController.text)! +
        (widget.isQuantity == true ? operation : 1000 * operation);

    if (calculus < 0) {
      setState(() => textEditingController.text = '0');
    } else {
      final quantity = int.tryParse(textEditingController.text)! +
          (widget.isQuantity == true ? operation : 1000 * operation);

      setState(() => textEditingController.text = quantity.toString());
    }
  }
}

import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberInputField extends ConsumerStatefulWidget {
  const NumberInputField(
      {super.key,
      required this.trailingText,
      required this.isQuantity,
      required this.onSave,
      required this.mapKey});

  final String trailingText;
  final bool isQuantity;
  final String mapKey;
  final void Function(String value) onSave;

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
    inputFocusNode.addListener(() {
      if (!inputFocusNode.hasFocus) {
        // Le focus a été perdu
        ref.read(postEventProvider.notifier).updateKey(
            widget.mapKey, int.tryParse(textEditingController.text) ?? 0);
      }
    });
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
    final state = ref.watch(postEventProvider);
    int quantity;

    if (state is Initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = state.infoMap[widget.mapKey].toString();
      });
      quantity = state.infoMap[widget.mapKey];
    } else {
      quantity = 0;
    }

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
                        quantity - (widget.isQuantity == true ? 1 : 1000);
                    if (calculus < 0) {
                      ref
                          .read(postEventProvider.notifier)
                          .updateKey(widget.mapKey, 0);
                    } else {
                      quantity =
                          quantity - (widget.isQuantity == true ? 1 : 1000);

                      ref
                          .read(postEventProvider.notifier)
                          .updateKey(widget.mapKey, quantity);
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
                  focusNode: inputFocusNode,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.center,
                  onEditingComplete: () {
                    final int? intValue =
                        int.tryParse(textEditingController.text);
                    if (intValue != null && intValue >= 0) {
                      ref
                          .read(postEventProvider.notifier)
                          .updateKey(widget.mapKey, intValue);
                    } else if (intValue == null) {
                      ref
                          .read(postEventProvider.notifier)
                          .updateKey(widget.mapKey, 0);
                    }
                    inputFocusNode.unfocus();
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
                  onSaved: (value) {
                    ref
                        .read(postEventProvider.notifier)
                        .updateKey(widget.mapKey, int.tryParse(value!));
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  final int calculus =
                      quantity + (widget.isQuantity == true ? 1 : 1000);
                  if (calculus < 0) {
                    ref
                        .read(postEventProvider.notifier)
                        .updateKey(widget.mapKey, 0);
                  } else {
                    quantity =
                        quantity + (widget.isQuantity == true ? 1 : 1000);

                    ref
                        .read(postEventProvider.notifier)
                        .updateKey(widget.mapKey, quantity);
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

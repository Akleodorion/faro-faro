import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescriptionTextFormField extends ConsumerStatefulWidget {
  const DescriptionTextFormField(
      {super.key, required this.isTicket, required this.mapKey});

  final bool isTicket;
  final String mapKey;

  @override
  ConsumerState<DescriptionTextFormField> createState() =>
      _DescriptionTextFormFieldState();
}

class _DescriptionTextFormFieldState
    extends ConsumerState<DescriptionTextFormField> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    textEditingController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        // Le focus a été perdu
        ref
            .read(postEventProvider.notifier)
            .updateKey(widget.mapKey, textEditingController.text);
        // Ajoutez ici le code à exécuter lorsque le champ perd le focus
      }
    });
  }

  bool hasError = false;
  double minHeight = 180;
  double maxHeight = 200;
  int maxCharsValue = 601;
  int minCharsValue = 50;

  @override
  Widget build(BuildContext context) {
    if (widget.isTicket == true) {
      minCharsValue = 20;
      maxCharsValue = 151;
      minHeight = 130;
      maxHeight = 150;
    }
    final double mediaWidth = MediaQuery.of(context).size.width;
    final state = ref.watch(postEventProvider);

    if (state is Initial) {
      textEditingController.text = state.infoMap[widget.mapKey];
    }

    return Container(
      width: (mediaWidth - 40),
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          maxLines: widget.isTicket == true ? 3 : 5,
          maxLength: maxCharsValue,
          decoration: InputDecoration(
            label: Text(
              widget.isTicket == true
                  ? "Description des prestations du ticket :"
                  : "Description de l'évènement :",
              style: const TextStyle(fontSize: 14),
            ),
          ),
          keyboardType: TextInputType.name,
          controller: textEditingController,
          focusNode: _descriptionFocusNode,
          validator: (value) {
            setState(() {
              hasError = false;
            });

            if (value!.trim().length <= minCharsValue) {
              setState(() {
                hasError = true;
              });
              return 'La description doit avoir un minimum de $minCharsValue caractères';
            }

            if (value.trim().length >= maxCharsValue) {
              hasError = true;
              return 'La description doit avoir un maximum de $maxCharsValue caractères';
            }
            return null;
          },
          onEditingComplete: () {
            ref
                .read(postEventProvider.notifier)
                .updateKey(widget.mapKey, textEditingController.text);
            _descriptionFocusNode.unfocus();
          },
          onSaved: (value) {
            ref
                .read(postEventProvider.notifier)
                .updateKey(widget.mapKey, value);
          },
        ),
      ),
    );
  }
}

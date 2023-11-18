import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleTextFormField extends ConsumerStatefulWidget {
  const TitleTextFormField({
    super.key,
  });

  @override
  ConsumerState<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends ConsumerState<TitleTextFormField> {
  bool hasError = false;

  TextEditingController titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        // Le focus a été perdu
        ref
            .read(postEventProvider.notifier)
            .updateKey('name', titleController.text);
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  double minHeight = 70.0;
  double maxHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    titleController.text = ref.read(postEventMapProvider)["name"];

    return Container(
      width: (mediaWidth - 40),
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text(
              "Nom de l'évènement :",
              style: TextStyle(fontSize: 12),
            ),
          ),
          controller: titleController,
          focusNode: _titleFocusNode,
          keyboardType: TextInputType.name,

          // validation
          validator: (value) {
            setState(() {
              hasError = false;
            });

            if (value!.trim().length <= 10) {
              setState(() {
                hasError = true;
              });
              return 'Le titre doit avoir un minimum de 10 caractères';
            }
            if (value.trim().length >= 50) {
              hasError = true;
              return 'Le titre doit avoir un maximum de 50 caractères';
            }
            return null;
          },

          onEditingComplete: () {
            final enteredTitle = titleController.text;
            ref
                .read(postEventProvider.notifier)
                .updateKey('name', enteredTitle);
            _titleFocusNode.unfocus();
          },
          onSaved: (value) {
            ref.read(postEventProvider.notifier).updateKey('name', value);
          },
        ),
      ),
    );
  }
}

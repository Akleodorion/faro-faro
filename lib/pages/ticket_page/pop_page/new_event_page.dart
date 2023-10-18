import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/sections/title_and_return_section.dart/title_and_navigatio_section.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/category_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/date_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/eco_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/number_input_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  String? _enteredTitle;
  String? selectedDate;
  Category? _selectedCategory;
  ModelEco? _selectedModelEco;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void _createNewEvent() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(42, 43, 42, 1),
              Color.fromRGBO(42, 43, 42, 0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleAndNavigationSection(),
                    const SizedBox(
                      height: 30,
                    ),
                    TitleTextFormField(
                      initialValue: _enteredTitle ?? '',
                      onSave: (value) {
                        setState(() {
                          _enteredTitle = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DatePickerField(
                          initialValue: selectedDate ?? '',
                          setValue: (value) {
                            setState(() {
                              selectedDate = DateFormat.yMd('fr').format(value);
                            });
                          },
                        ),
                        CategoryPickerField(
                          initialValue: _selectedCategory ?? Category.concert,
                          setValue: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        EcoPickerField(
                          initialValue: _selectedModelEco ?? ModelEco.gratuit,
                          setValue: (value) {
                            setState(() {
                              _selectedModelEco = value;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Placeholder(
                      fallbackHeight: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.pin_drop),
                          label: const Text("Hello"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.map),
                          label: const Text("Hello"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Placeholder(
                      fallbackHeight: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.image),
                          label: const Text("Selectionner une image"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Nombre de ticket disponible : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              const TextSpan(
                                text: 'XX',
                                style:
                                    TextStyle(fontSize: 24, color: Colors.red),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //! modif
                    const NumberInputField(
                      trailingText: "Nombre de ticket standard :",
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ElevatedButton(
                        onPressed: () {
                          _createNewEvent();
                        },
                        child: Text("hello"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

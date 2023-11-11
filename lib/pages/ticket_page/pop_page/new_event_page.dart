import 'package:faro_clean_tdd/features/address/presentation/providers/address_provider.dart';
import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_state.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/map_page.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/sections/title_and_return_section.dart/title_and_navigatio_section.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/category_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/date_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/description_text_form_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/eco_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/image_input.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/number_input_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class NewEventPage extends ConsumerStatefulWidget {
  const NewEventPage({super.key});

  @override
  ConsumerState<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends ConsumerState<NewEventPage> {
  String? _enteredTitle;
  String? _enteredStandardTicketDescription;
  String? _enteredVipStandardTicketDescription;
  String? _enteredVVipStandardTicketDescription;
  String? selectedDate;
  Category? _selectedCategory;
  ModelEco? _selectedModelEco;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final addressState = ref.watch(addressProvider);

    Widget locationContent = const Center(child: Text("No place choosen"));

    void createNewEvent() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
      }
    }

    if (addressState is Loading) {
      locationContent = const Center(child: CircularProgressIndicator());
    } else if (addressState is Loaded) {
      locationContent = Image.network(
        addressState.address.geocodeUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
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
            key: formKey,
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
                    DescriptionTextFormField(
                        isTicket: false,
                        initialValue:
                            _enteredVVipStandardTicketDescription ?? '',
                        onSave: (value) {
                          setState(() {
                            _enteredTitle = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      child: locationContent,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            ref
                                .read(addressProvider.notifier)
                                .getCurrentLocationAddress();
                          },
                          icon: const Icon(Icons.pin_drop),
                          label: const Text("Current position"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final pickedLocation = await Navigator.of(context)
                                .push<LatLng>(MaterialPageRoute(builder: (ctx) {
                              return const MapScreen();
                            }));
                            if (pickedLocation == null) {
                              return;
                            }
                            ref
                                .read(addressProvider.notifier)
                                .getSelectedLociationAddress(
                                    pickedLocation.latitude,
                                    pickedLocation.longitude);
                          },
                          icon: const Icon(Icons.map),
                          label: const Text("Select on map"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ImageInput(),
                    const SizedBox(
                      height: 20,
                    ),

                    //! Standard
                    const Center(
                      child: Text('Ticket Standard',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        initialValue: _enteredStandardTicketDescription ?? '',
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredTitle = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Vip
                    const Center(
                      child: Text('Ticket Vip',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        initialValue:
                            _enteredVipStandardTicketDescription ?? '',
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredTitle = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Vvip
                    const Center(
                      child: Text('Ticket Vvip',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        initialValue:
                            _enteredVVipStandardTicketDescription ?? '',
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredTitle = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: UsecaseElevatedButton(
                          usecaseTitle: 'Poste ton évènement !',
                          onUsecaseCall: createNewEvent),
                    ),
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

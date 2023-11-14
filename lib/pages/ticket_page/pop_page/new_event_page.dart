import 'dart:io';

import 'package:faro_clean_tdd/features/pick_image/presentation/providers/picked_image_provider.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_state.dart'
    as pi;
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart'
    as ua;
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/sections/title_and_return_section.dart/title_and_navigatio_section.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/category_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/date_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/description_text_form_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/eco_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/image_input.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/map_input.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/number_input_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class NewEventPage extends ConsumerStatefulWidget {
  const NewEventPage({super.key});

  @override
  ConsumerState<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends ConsumerState<NewEventPage> {
  String? _enteredTitle;
  String? _enteredEventDescription;
  String? _enteredVipStandardTicketDescription;
  String? _enteredVVipStandardTicketDescription;
  String? _enteredStandardTicketDescription;
  int? standardTicketPrice;
  int? maxStandardTicket;
  int? vipTicketPrice;
  int? maxVipTicket;
  int? vvipTicketPrice;
  int? maxVvipTicket;
  String? enteredAddress;
  double? pickedLatitude;
  double? pickedLongitude;
  String? pickedImageUrl;
  String? selectedDate;
  Category? _selectedCategory;
  ModelEco? _selectedModelEco;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void createNewEvent() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final userState = ref.read(userAuthProvider);
        final pickImageState = ref.read(pickedImageProvider);

        final myEventModel = EventModel(
            name: _enteredTitle!,
            eventId: 0,
            description: _enteredEventDescription!,
            date: DateFormat('dd/MM/yyyy').parse(selectedDate!),
            address: enteredAddress!,
            latitude: pickedLatitude!,
            longitude: pickedLongitude!,
            category: _selectedCategory!,
            imageUrl: pickImageState is pi.Loaded
                ? pickImageState.pickedImage.image.path
                : '',
            userId: userState is ua.Loaded ? userState.user.id : 1,
            modelEco: _selectedModelEco!,
            standardTicketPrice: standardTicketPrice!,
            maxStandardTicket: maxStandardTicket!,
            standardTicketDescription: _enteredStandardTicketDescription!,
            vipTicketPrice: vipTicketPrice!,
            maxVipTicket: maxVipTicket!,
            vipTicketDescription: _enteredVipStandardTicketDescription!,
            vvipTicketPrice: vvipTicketPrice!,
            maxVvipTicket: maxVvipTicket!,
            vvipTicketDescription: _enteredVVipStandardTicketDescription!);

        final state = await ref.read(eventProvider.notifier).postAnEvent(
              event: myEventModel,
              image: pickImageState is pi.Loaded
                  ? pickImageState.pickedImage.image
                  : File(''),
            );

        if (state is Error) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: theme.colorScheme.surface,
              content: Text(
                state.message,
                style: TextStyle(
                    // ignore: use_build_context_synchronously
                    color: theme.colorScheme.secondary),
              )));
        }

        if (state is Loaded) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
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
                          onSave: (value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                        ),
                        CategoryPickerField(
                          onSave: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        EcoPickerField(
                          onSave: (value) {
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
                        onSave: (value) {
                          setState(() {
                            _enteredEventDescription = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    MapInput(
                      onSetAddress: (address) {
                        enteredAddress = address.addressName;
                        pickedLatitude = address.latitude;
                        pickedLongitude = address.longitude;
                      },
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                          onSave: (value) {
                            setState(() {
                              maxStandardTicket = int.tryParse(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                          onSave: (value) {
                            setState(() {
                              standardTicketPrice = int.tryParse(value);
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredStandardTicketDescription = value;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                          onSave: (value) {
                            setState(() {
                              maxVipTicket = int.tryParse(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                          onSave: (value) {
                            setState(() {
                              vipTicketPrice = int.tryParse(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredVipStandardTicketDescription = value;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberInputField(
                          trailingText: "Nombre de ticket :",
                          isQuantity: true,
                          onSave: (value) {
                            setState(() {
                              maxVvipTicket = int.tryParse(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        NumberInputField(
                          trailingText: "Prix d'un ticket :",
                          isQuantity: false,
                          onSave: (value) {
                            setState(() {
                              vvipTicketPrice = int.tryParse(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DescriptionTextFormField(
                        isTicket: true,
                        onSave: (value) {
                          setState(() {
                            _enteredVVipStandardTicketDescription = value;
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

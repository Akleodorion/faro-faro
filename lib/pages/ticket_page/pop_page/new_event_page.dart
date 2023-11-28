import 'package:faro_clean_tdd/features/address/presentation/providers/address_provider.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/picked_image_provider.dart';

import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/main.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/sections/title_and_return_section.dart/title_and_navigatio_section.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/category_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/date_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/description_text_form_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/eco_picker_field.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/image_input.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/map_input.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/ticket_column.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/events/data/models/event_model.dart';

class NewEventPage extends ConsumerWidget {
  const NewEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final state = ref.read(postEventProvider);
    Widget content;
    late String enteredName;
    late DateTime enteredDateTime;
    late Category pickedCategory;
    late ModelEco pickedModelEco;
    late String? enteredDescription;
    late int standardTicketNumber;
    late String? standardTicketDescritpion;
    int? standardTicketPrice;
    String? goldTicketDescription;
    int? goldTicketNumber;
    int? goldTicketPrice;
    String? platinumTicketDescription;
    int? platinumTicketNumber;
    int? platinumTicketPrice;

    void createNewEvent() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        // récupération des infos utilisateurs & de l'event en cours de création
        final userId = ref.read(userInfoProvider)["user_id"];
        final pickedAddress = ref.read(pickedAddressProvider);
        final pickedImage = ref.read(pickedImagedProvider);

        // Création du model
        final myEventModel = EventModel(
            name: enteredName,
            eventId: 13485245,
            description: enteredDescription ?? '',
            date: enteredDateTime,
            startTime: const TimeOfDay(hour: 00, minute: 00),
            endTime: const TimeOfDay(hour: 02, minute: 00),
            address: pickedAddress!,
            category: pickedCategory,
            imageUrl: "",
            userId: userId,
            modelEco: pickedModelEco,
            members: const [],
            tickets: const [],
            activated: false,
            closed: false,
            standardTicketPrice: standardTicketPrice,
            maxStandardTicket: standardTicketNumber,
            standardTicketDescription: standardTicketDescritpion ?? '',
            goldTicketPrice: goldTicketPrice,
            maxGoldTicket: goldTicketNumber,
            goldTicketDescription: goldTicketDescription,
            platinumTicketPrice: platinumTicketPrice,
            maxPlatinumTicket: platinumTicketNumber,
            platinumTicketDescription: platinumTicketDescription);

        // Usecase
        final state = await ref
            .read(postEventProvider.notifier)
            .postAnEvent(event: myEventModel, image: pickedImage!.image);

        // Si une erreur alors snackbar
        if (state is Error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: theme.colorScheme.background,
              content: Text(
                state.message,
                style: TextStyle(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ));
          });
        }

        // Si tout bon alors pop
        if (state is Loaded) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
      }
    }

    if (state is Loading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = SafeArea(
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
                  TitleTextFormField(setValue: (value) {
                    enteredName = value;
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatePickerField(setValue: (value) {
                        enteredDateTime = value;
                      }),
                      CategoryPickerField(setValue: (value) {
                        pickedCategory = value;
                      }),
                      EcoPickerField(setValue: (value) {
                        pickedModelEco = value;
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DescriptionTextFormField(
                      key: const ValueKey('hi'),
                      isTicket: false,
                      mapKey: "description",
                      setValue: (value) {
                        enteredDescription = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const MapInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ImageInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  TicketColumn(setStandardTicketDescription: (value) {
                    standardTicketDescritpion = value;
                  }, setStandardTicketNumber: (value) {
                    standardTicketNumber = value!;
                  }, setStandardTicketPrice: (value) {
                    standardTicketPrice = value;
                  }, setGoldTicketDescription: (value) {
                    goldTicketDescription = value;
                  }, setGoldTicketNumber: (value) {
                    goldTicketNumber = value;
                  }, setGoldTicketPrice: (value) {
                    goldTicketPrice = value;
                  }, setPlatinumTicketDescription: (value) {
                    platinumTicketDescription = value;
                  }, setPlatinumTicketNumber: (value) {
                    platinumTicketNumber = value;
                  }, setPlatinumTicketPrice: (value) {
                    platinumTicketPrice = value;
                  }),
                  const SizedBox(
                    height: 20,
                  ),
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
        child: content,
      ),
    );
  }
}

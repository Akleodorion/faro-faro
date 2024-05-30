// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/address/presentation/providers/address_provider.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/sections/title_and_return_section.dart/title_and_navigatio_section.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/category_picker_field.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/date_picker_field.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/description_text_form_field.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/eco_picker_field.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/image_input.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/map_input.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/ticket_column.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/time_picker_field.dart';
import 'package:faro_faro/features/events/presentation/pages/new_event_page/widgets/title_text_form_field.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:faro_faro/features/pick_image/presentation/providers/picked_image_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import '../../../data/models/event_model.dart';
import 'widgets/usecase_elevated_button.dart';

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
    late TimeOfDay pickedStartTime;
    late TimeOfDay pickedEndTime;
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

        final userId = ref.read(userInfoProvider)["user_id"];
        final pickedAddress = ref.read(pickedAddressProvider);
        final pickedImage = ref.read(pickedImagedProvider);

        final myEventModel = EventModel(
          name: enteredName,
          id: null,
          description: enteredDescription ?? '',
          date: enteredDateTime,
          startTime: pickedStartTime,
          endTime: pickedEndTime,
          address: pickedAddress!,
          category: pickedCategory,
          imageUrl: "",
          userId: userId,
          modelEco: pickedModelEco,
          members: const [],
          tickets: const [],
          activated: false,
          closed: false,
          standardTicketPrice:
              standardTicketPrice == 0 ? null : standardTicketPrice,
          maxStandardTicket: standardTicketNumber,
          standardTicketDescription: standardTicketDescritpion ?? '',
          goldTicketPrice: goldTicketPrice == 0 ? null : goldTicketPrice,
          maxGoldTicket: goldTicketNumber == 0 ? null : goldTicketNumber,
          goldTicketDescription: goldTicketDescription,
          platinumTicketPrice:
              platinumTicketPrice == 0 ? null : platinumTicketPrice,
          maxPlatinumTicket:
              platinumTicketNumber == 0 ? null : platinumTicketNumber,
          platinumTicketDescription: platinumTicketDescription,
        );

        final state = await ref
            .read(postEventProvider.notifier)
            .postAnEvent(event: myEventModel, image: pickedImage!.image);

        if (state is Error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              content: Text(
                state.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ));
          });
        }

        if (state is Loaded && context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }

    if (state is Loading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryPickerField(setValue: (value) {
                        pickedCategory = value;
                      }),
                      const SizedBox(
                        width: 20,
                      ),
                      EcoPickerField(setValue: (value) {
                        pickedModelEco = value;
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Date et heure de l'évenèment",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatePickerField(setValue: (value) {
                        enteredDateTime = value;
                      }),
                      TimePickerField(
                        setValue: (value) {
                          pickedStartTime = value;
                        },
                        startOrEndTime: "start_time",
                      ),
                      TimePickerField(
                        setValue: (value) {
                          pickedEndTime = value;
                        },
                        startOrEndTime: "end_time",
                      ),
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
                  TicketColumn(
                    setStandardTicketDescription: (value) {
                      standardTicketDescritpion = value;
                    },
                    setStandardTicketNumber: (value) {
                      standardTicketNumber = value!;
                    },
                    setStandardTicketPrice: (value) {
                      standardTicketPrice = value;
                    },
                    setGoldTicketDescription: (value) {
                      goldTicketDescription = value;
                    },
                    setGoldTicketNumber: (value) {
                      goldTicketNumber = value;
                    },
                    setGoldTicketPrice: (value) {
                      goldTicketPrice = value;
                    },
                    setPlatinumTicketDescription: (value) {
                      platinumTicketDescription = value;
                    },
                    setPlatinumTicketNumber: (value) {
                      platinumTicketNumber = value;
                    },
                    setPlatinumTicketPrice: (value) {
                      platinumTicketPrice = value;
                    },
                  ),
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

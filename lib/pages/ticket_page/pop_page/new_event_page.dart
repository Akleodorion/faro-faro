import 'dart:io';

import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart'
    as us;

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

    void createNewEvent() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final userState = ref.read(userAuthProvider);
        final postAnEventState = ref.read(postEventProvider);

        final myEventModel = getEventModel(
            postEventState: postAnEventState, userState: userState);
        final state = await ref.read(postEventProvider.notifier).postAnEvent(
            event: myEventModel!,
            image: postAnEventState is Initial
                ? postAnEventState.infoMap["imageFile"]
                : File(''));

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
          ref.read(postEventProvider.notifier).reset(state.infoMap);
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
                    const TitleTextFormField(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DatePickerField(),
                        CategoryPickerField(),
                        EcoPickerField()
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DescriptionTextFormField(
                      key: ValueKey('hi'),
                      isTicket: false,
                      mapKey: "description",
                    ),
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
                    const TicketColumn(),
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
        ),
      ),
    );
  }
}

EventModel? getEventModel(
    {required PostEventState postEventState, required us.UserState userState}) {
  if (postEventState is Initial && userState is us.Loaded) {
    final myEventModel = EventModel(
        name: postEventState.infoMap["name"],
        eventId: 0,
        description: postEventState.infoMap["description"]!,
        date: postEventState.infoMap["date"],
        address: postEventState.infoMap["address"],
        latitude: postEventState.infoMap["latitude"]!,
        longitude: postEventState.infoMap["longitude"]!,
        category: postEventState.infoMap["category"]!,
        imageUrl: '',
        userId: userState.user.id,
        modelEco: postEventState.infoMap["modelEco"],
        standardTicketPrice: postEventState.infoMap["standardTicketPrice"],
        maxStandardTicket: postEventState.infoMap["maxStandardTicket"],
        standardTicketDescription:
            postEventState.infoMap["standardTicketDescription"],
        vipTicketPrice: postEventState.infoMap["vipTicketPrice"]!,
        maxVipTicket: postEventState.infoMap["maxVipTicket"],
        vipTicketDescription: postEventState.infoMap["vipTicketDescription"],
        vvipTicketPrice: postEventState.infoMap["vvipTicketPrice"],
        maxVvipTicket: postEventState.infoMap["maxVvipTicket"]!,
        vvipTicketDescription:
            postEventState.infoMap["vvipTicketDescription"]!);

    return myEventModel;
  }

  return null;
}

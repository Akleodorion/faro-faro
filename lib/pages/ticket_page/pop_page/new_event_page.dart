import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';

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

    void createNewEvent() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        // récupération des infos utilisateurs & de l'event en cours de création
        final userId = ref.read(userInfoProvider)["user_id"];
        final postEventMap = ref.read(postEventMapProvider);

        // Création du model
        final myEventModel = EventModel(
            name: postEventMap["name"],
            eventId: postEventMap["event_id"],
            description: postEventMap["description"],
            date: postEventMap["date"],
            address: postEventMap["address"],
            category: postEventMap["category"],
            imageUrl: postEventMap["image_url"],
            userId: userId,
            modelEco: postEventMap["model_eco"],
            members: const [],
            standardTicketPrice: postEventMap["standard_ticket_price"],
            maxStandardTicket: postEventMap["max_standard_ticket"],
            standardTicketDescription:
                postEventMap["standard_ticket_description"],
            vipTicketPrice: postEventMap["vip_ticket_price"],
            maxVipTicket: postEventMap["max_vip_ticket"],
            vipTicketDescription: postEventMap["vip_ticket_description"],
            vvipTicketPrice: postEventMap["vvip_ticket_price"],
            maxVvipTicket: postEventMap["max_vvip_ticket"],
            vvipTicketDescription: postEventMap["vvip_ticket_description"]);

        // Usecase
        final state = await ref.read(postEventProvider.notifier).postAnEvent(
              event: myEventModel,
              image: postEventMap["imageFile"],
            );

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
          ref.read(postEventProvider.notifier).reset(state.infoMap);
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

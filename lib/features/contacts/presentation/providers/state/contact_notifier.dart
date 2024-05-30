// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:faro_faro/features/contacts/presentation/providers/state/contact_state.dart';

class ContactNotifier extends StateNotifier<ContactState> {
  ContactNotifier({required this.usecase}) : super(Loading());

  final FetchContactUsecase usecase;
  ContactState get initialState => Loading();

  Future<ContactState> fetchContact({required List<String> numbers}) async {
    final result = await usecase.execute(numbers: numbers);
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (contacts) {
      state =
          Loaded(contacts: contacts, message: "Contacts récupérés avec succès");
    });
    return state;
  }
}

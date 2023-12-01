import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactNotifier extends StateNotifier<ContactState> {
  ContactNotifier({required this.usecase}) : super(Loading());

  final FetchContactUsecase usecase;
  ContactState get initialState => Loading();

  Future<ContactState> fetchContact() async {
    final result = await usecase.execute();
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (contacts) {
      state = Loaded(contacts: contacts);
    });
    return state;
  }
}

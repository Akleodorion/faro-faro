// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';
import 'package:faro_faro/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:faro_faro/features/contacts/presentation/providers/state/contact_notifier.dart';
import 'package:faro_faro/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:faro_faro/injection_container.dart';

final contactStateProvider =
    StateNotifierProvider<ContactNotifier, ContactState>((ref) {
  final FetchContactUsecase usecase = sl<FetchContactUsecase>();

  return ContactNotifier(usecase: usecase);
});

final contactsListProvider = Provider<List<Contact>>((ref) {
  final state = ref.watch(contactStateProvider);
  if (state is Loaded) {
    return state.contacts;
  }
  return [];
});

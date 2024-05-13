import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool assignCheckedStatus({
  required WidgetRef ref,
}) {
  final state = ref.read(loggedInProvider);
  return state is Unloaded ? state.userInfo["pref"] : false;
}

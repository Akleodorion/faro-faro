// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';

bool assignCheckedStatus({
  required WidgetRef ref,
}) {
  final state = ref.read(loggedInProvider);
  return state is Unloaded ? state.userInfo["pref"] : false;
}

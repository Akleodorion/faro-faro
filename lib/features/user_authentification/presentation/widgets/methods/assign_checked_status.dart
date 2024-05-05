import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool assignCheckedStatus({
  required WidgetRef ref,
}) {
  final state = ref.read(userAuthProvider);
  return state is Initial ? state.userInfo["pref"] : false;
}

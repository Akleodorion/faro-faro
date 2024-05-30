// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/user_provider.dart';

/// Cette méthode appel soit le usecase logUserIn soit signUserIn
/// Elle prend en paramètre ref, la map de logInfo et isLogingIn
///
/// Pour connecter l'utilisateur à son compte
///
/// En cas d'erreur jette un [UtilException] avec le message d'erreur
Future<UserState> logOrSignUserIn({
  required WidgetRef ref,
  required Map<String, dynamic> logInInfoMap,
  required bool isLogingIn,
}) async {
  late UserState state;
  if (isLogingIn) {
    state = await ref.read(userAuthProvider.notifier).logUserIn(
          logInInfoMap["email"] as String,
          logInInfoMap["password"] as String,
          logInInfoMap["pref"] as bool,
        );
  } else {
    state = await ref.read(userAuthProvider.notifier).signUserIn(
          logInInfoMap["email"],
          logInInfoMap["password"],
          logInInfoMap["phoneNumber"],
          logInInfoMap["username"],
          logInInfoMap["pref"],
        );
  }
  if (state is Error) {
    throw UtilException(errorMessage: state.message);
  }
  return state;
}

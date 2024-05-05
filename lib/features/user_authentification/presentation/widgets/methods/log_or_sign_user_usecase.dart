import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cette méthode appel soit le usecase logUserIn soit signUserIn
/// Elle prend en paramètre ref, la map de logInfo et isLogingIn
///
/// Pour connecter l'utilisateur à son compte
///
/// En cas d'erreur jette un [UtilException] avec le message d'erreur
Future<void> logOrSignUserIn({
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

  state is Error ? throw UtilException(errorMessage: state.message) : null;
}

import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';

import 'state/user_notifier.dart';
import 'state/user_state.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/log_user_in.dart';
import '../../../domain/usecases/sign_user_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    final LogUserIn logUserIn = sl<LogUserIn>();
    final SignUserIn signUserInUsecase = sl<SignUserIn>();
    final LogUserOutUsecase logUserOutUsecase = sl<LogUserOutUsecase>();

    return UserNotifier(
        logUserInUsecase: logUserIn,
        signUserInUsecase: signUserInUsecase,
        logUserOutUsecase: logUserOutUsecase);
  },
);

final userLoginStatusProvider = Provider<bool>((ref) {
  final state = ref.watch(userAuthProvider);
  if (state is Loaded) {
    return true;
  }
  return false;
});

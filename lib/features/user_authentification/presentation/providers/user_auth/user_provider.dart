import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';

import '../../../domain/usecases/get_user_info.dart';
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
    final GetUserInfo getUserInfoUsecase = sl<GetUserInfo>();
    final LogUserOutUsecase logUserOutUsecase = sl<LogUserOutUsecase>();

    return UserNotifier(
        logUserInUsecase: logUserIn,
        signUserInUsecase: signUserInUsecase,
        getUserInfoUsecase: getUserInfoUsecase,
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

import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';

import '../../domain/usecases/get_user_info.dart';
import '../../domain/usecases/log_in_with_token.dart';
import 'state/user_notifier.dart';
import 'state/user_state.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/log_user_in.dart';
import '../../domain/usecases/sign_user_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    final LogUserIn logUserIn = sl<LogUserIn>();
    final SignUserIn signUserInUsecase = sl<SignUserIn>();
    final GetUserInfo getUserInfoUsecase = sl<GetUserInfo>();
    final LogInWithToken logInWithToken = sl<LogInWithToken>();
    final LogUserOutUsecase logUserOutUsecase = sl<LogUserOutUsecase>();

    return UserNotifier(
        logInWithTokenUsecase: logInWithToken,
        logUserInUsecase: logUserIn,
        signUserInUsecase: signUserInUsecase,
        getUserInfoUsecase: getUserInfoUsecase,
        logUserOutUsecase: logUserOutUsecase);
  },
);

final userInfoProvider = Provider<Map<String, dynamic>>((ref) {
  final state = ref.read(userAuthProvider);
  if (state is Loaded) {
    return {
      'username': state.user.username,
      'phone_number': state.user.phoneNumber,
      'user_id': state.user.id,
      'email': state.user.email,
      'jwt': state.user.jwtToken
    };
  }
  return {};
});

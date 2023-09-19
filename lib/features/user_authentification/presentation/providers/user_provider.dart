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

    return UserNotifier(
      logInWithTokenUsecase: logInWithToken,
        logUserInUsecase: logUserIn,
        signUserInUsecase: signUserInUsecase,
        getUserInfoUsecase: getUserInfoUsecase);
  },
);

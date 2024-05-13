import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loggedInProvider = StateNotifierProvider<LoggedInNotifier, LoggedInState>(
  (ref) {
    final GetUserInfo getUserInfoUsecase = sl<GetUserInfo>();
    final LogInWithToken logInWithTokenUsecase = sl<LogInWithToken>();

    return LoggedInNotifier(
        getUserInfoUsecase: getUserInfoUsecase,
        logInWithTokenUsecase: logInWithTokenUsecase);
  },
);

final userInfoProvider = Provider<Map<String, dynamic>>(
  (ref) {
    final state = ref.watch(loggedInProvider);
    if (state is Loaded) {
      return {
        'username': state.user.username,
        'phone_number': state.user.phoneNumber,
        'user_id': state.user.id,
        'email': state.user.email,
        'jwt': state.user.jwtToken
      };
    } else if (state is Unloaded) {
      return state.userInfo;
    }
    return {};
  },
);

import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import '../../domain/usecases/log_user_in.dart';
import '../../domain/usecases/sign_user_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    final LogUserIn logUserIn = sl<LogUserIn>();
    final SignUserIn signUserInUsecase = sl<SignUserIn>();
    final GetUserInfo getUserInfoUsecase = sl<GetUserInfo>();

    return UserNotifier(
        logUserInUsecase: logUserIn,
        signUserInUsecase: signUserInUsecase,
        getUserInfoUsecase: getUserInfoUsecase);
  },
);

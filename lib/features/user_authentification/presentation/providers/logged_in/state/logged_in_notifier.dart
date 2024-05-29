import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggedInNotifier extends StateNotifier<LoggedInState> {
  final GetUserInfo getUserInfoUsecase;
  final LogInWithToken logInWithTokenUsecase;
  LoggedInNotifier({
    required this.getUserInfoUsecase,
    required this.logInWithTokenUsecase,
  }) : super(Loading());

  // méthodes

  Future<LoggedInState> logInWithToken() async {
    final response = await logInWithTokenUsecase.call();
    if (response == null) {
      final userInfoMap = await getUserInfoUsecase.call();
      state = Unloaded(userInfo: userInfoMap);
    } else {
      state = Loaded(user: response, message: "succes");
    }
    return state;
  }

  void statusToLoaded(User user) {
    state = Loading();
    state = Loaded(user: user, message: "message");
  }

  Future<void> statusToUnloaded() async {
    state = Loading();
    final userInfoMap = await getUserInfoUsecase.call();
    state = Unloaded(userInfo: userInfoMap);
  }

  void togglePref(Map<String, dynamic> prevState, bool isActive) async {
    final newState = {
      "email": prevState["email"],
      "password": prevState["password"],
      "token": prevState["token"],
      "datetime": prevState["datetime"],
      "pref": isActive,
    };
    state = Unloaded(userInfo: newState);
  }
}

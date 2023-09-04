import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/log_user_in.dart';
import '../../../domain/usecases/sign_user_in.dart' as si;

class UserNotifier extends StateNotifier<UserState> {
  final LogUserIn logUserInUsecase;
  final si.SignUserIn signUserInUsecase;
  final GetUserInfo getUserInfoUsecase;
  UserState get initialState => Loading();

  UserNotifier(
      {required this.logUserInUsecase,
      required this.signUserInUsecase,
      required this.getUserInfoUsecase})
      : super(Loading());

  Future<UserState> logUserIn(String email, String password, bool pref) async {
    state = Loading();
    final response = await logUserInUsecase
        .call(Params(email: email, password: password, pref: pref));
    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (user) {
      state = Loaded(user: user!);
    });

    return state;
  }

  Future<UserState> signUserIn(String email, String password,
      String phoneNumber, String username, bool pref) async {
    state = Loading();
    final response = await signUserInUsecase.call(si.Params(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber,
        pref: pref));

    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (user) {
      state = Loaded(user: user!);
    });

    return state;
  }

  Future<UserState> getUserInfo() async {
    final response = await getUserInfoUsecase.call();
    print(response);
    state = Initial(userInfo: response!);
    return state;
  }

  void togglePref(Map<String, dynamic> prevState, bool isActive) async {
    final newState = {
      "email": prevState["email"],
      "password": prevState["password"],
      "token": prevState["token"],
      "datetime": prevState["datetime"],
      "pref": isActive
    };
    state = Initial(userInfo: newState);
  }
}

import 'dart:async';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';
import 'package:flutter/services.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/get_user_info.dart';
import '../../../domain/usecases/log_in_with_token.dart';
import 'user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/log_user_in.dart';
import '../../../domain/usecases/sign_user_in.dart' as si;

class UserNotifier extends StateNotifier<UserState> {
  final LogUserIn logUserInUsecase;
  final LogInWithToken logInWithTokenUsecase;
  final si.SignUserIn signUserInUsecase;
  final LogUserOutUsecase logUserOutUsecase;
  final GetUserInfo getUserInfoUsecase;

  UserState get initialState => Loading();

  UserNotifier(
      {required this.logUserInUsecase,
      required this.signUserInUsecase,
      required this.logInWithTokenUsecase,
      required this.getUserInfoUsecase,
      required this.logUserOutUsecase})
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
      state = Loaded(user: user!, message: "Connecté avec succès!");
    });

    return state;
  }

  Future<UserState> reset() async {
    state = Loading();
    state = await getUserInfo();
    return state;
  }

  Future<UserState> signUserIn(String email, String password,
      String phoneNumber, String username, bool pref) async {
    state = Loading();
    final response = await signUserInUsecase.call(
      si.Params(
          email: email,
          password: password,
          username: username,
          phoneNumber: phoneNumber,
          pref: pref),
    );

    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (user) {
      state =
          Loaded(user: user!, message: "Votre compte a été créer avec succès!");
    });

    return state;
  }

  Future<UserState?> logUserOut({required String jwt}) async {
    state = Loading();
    await logUserOutUsecase.execute(jwt: jwt);
    await restartApp();
    state = await getUserInfo();
    return state;
  }

  Future<void> restartApp() async {
    await SystemNavigator.pop();
  }

  Future<UserState> getUserInfo() async {
    final response = await getUserInfoUsecase.call();
    state = Initial(userInfo: response!);
    return state;
  }

  Future<UserState> logInWithToken() async {
    final response = await logInWithTokenUsecase.call();
    if (response == null) {
      return await getUserInfo();
    }
    state = Loaded(user: response, message: "Connecté avec succès!");

    return state;
  }

  void togglePref(Map<String, dynamic> prevState, bool isActive) async {
    final newState = {
      "email": prevState["email"],
      "password": prevState["password"],
      "token": prevState["token"],
      "datetime": prevState["datetime"],
      "pref": isActive,
    };
    state = Initial(userInfo: newState);
  }
}

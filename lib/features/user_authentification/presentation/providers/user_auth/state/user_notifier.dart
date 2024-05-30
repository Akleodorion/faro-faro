// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/domain/usecases/log_user_out.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../domain/usecases/log_user_in.dart';
import '../../../../domain/usecases/sign_user_in.dart' as si;
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final LogUserIn logUserInUsecase;
  final si.SignUserIn signUserInUsecase;
  final LogUserOutUsecase logUserOutUsecase;

  UserState get initialState => Unloaded();

  UserNotifier(
      {required this.logUserInUsecase,
      required this.signUserInUsecase,
      required this.logUserOutUsecase})
      : super(Unloaded());

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
    state = Unloaded();
    return state;
  }
}

import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/log_user_in.dart';
import '../../../domain/usecases/sign_user_in.dart' as si;

class UserNotifier extends StateNotifier<UserState> {
  final LogUserIn logUserInUsecase;
  final si.SignUserIn signUserInUsecase;
  UserState get initialState => Initial();

  UserNotifier({
    required this.logUserInUsecase,
    required this.signUserInUsecase,
  }) : super(Initial());

  Future<UserState> logUserIn(String email, String password) async {
    state = Loading();
    final response =
        await logUserInUsecase.call(Params(email: email, password: password));
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
      String phoneNumber, String username) async {
    state = Loading();
    final response = await signUserInUsecase.call(si.Params(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber));

    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (user) {
      state = Loaded(user: user!);
    });

    return state;
  }
}

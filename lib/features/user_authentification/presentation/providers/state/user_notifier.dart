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
      state = Error(message: "An error as occured");
    }, (user) {
      state = Loaded(user: user!);
    });

    return state;
  }

  Future<void> signUserIn(String email, String password, String phoneNumber,
      String username) async {
    state = Loading();
    final response = await signUserInUsecase.call(si.Params(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber));

    response.fold((failure) {
      state = Error(message: 'oops');
    }, (user) {
      state = Loaded(user: user!);
    });
  }
}

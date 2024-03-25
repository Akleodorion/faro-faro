import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/request_reset_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/reset_password.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/password/state/password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordNotifier extends StateNotifier<PasswordState> {
  final RequestResetTokenUsecase requestResetTokenUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  PasswordNotifier({
    required this.requestResetTokenUsecase,
    required this.resetPasswordUsecase,
  }) : super(Initial());

  PasswordState get initialState => Initial();

  // les méthodes.

  Future<PasswordState> requestResetToken({required String email}) async {
    // faire la requête
    state = Loading();
    final result = await requestResetTokenUsecase.execute(email: email);
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (r) {
      state = Initial();
    });
    return state;
  }

  Future<PasswordState> resetPassword(
      {required String email,
      required String token,
      required String newPassword}) async {
    state = Loading();
    final result = await resetPasswordUsecase.execute(
        email: email, token: token, newPassword: newPassword);
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (success) {
      state = Initial();
    });
    return state;
  }
}

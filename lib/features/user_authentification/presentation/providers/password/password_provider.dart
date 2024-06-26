// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/domain/usecases/request_reset_token.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/reset_password.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/state/password_notifier.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/state/password_state.dart';
import 'package:faro_faro/injection_container.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, PasswordState>((ref) {
  final RequestResetTokenUsecase requestResetTokenUsecase =
      sl<RequestResetTokenUsecase>();
  final ResetPasswordUsecase resetPasswordUsecase = sl<ResetPasswordUsecase>();

  return PasswordNotifier(
    requestResetTokenUsecase: requestResetTokenUsecase,
    resetPasswordUsecase: resetPasswordUsecase,
  );
});

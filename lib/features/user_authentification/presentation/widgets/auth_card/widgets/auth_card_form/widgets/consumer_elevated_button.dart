// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/show_result_message_snackbar.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/constants/constants.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/methods/assign_checked_status.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/methods/log_or_sign_user_usecase.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/methods/validate_form.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';

class ConsumerElevatedButton extends ConsumerWidget {
  const ConsumerElevatedButton(
      {super.key,
      required this.logingIn,
      required this.logInInfo,
      required this.formKey});
  final bool logingIn;
  final Map<String, dynamic> logInInfo;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userAuthProvider);
    final isLoading = state is Loading;
    return UsecaseElevatedButton(
        usecaseTitle: logingIn ? Strings.logIn : Strings.signIn,
        onUsecaseCall: () async {
          await _userLoginOrSignIn(
            formKey: formKey,
            ref: ref,
            logInInfoMap: logInInfo,
            context: context,
          );
        },
        isLoading: isLoading);
  }

  Future<void> _userLoginOrSignIn({
    required GlobalKey<FormState>? formKey,
    required WidgetRef ref,
    required Map<String, dynamic> logInInfoMap,
    required BuildContext context,
  }) async {
    try {
      validateForm(form: formKey);
      logInInfo["pref"] = assignCheckedStatus(ref: ref);
      final userState = await logOrSignUserIn(
          ref: ref, logInInfoMap: logInInfoMap, isLogingIn: logingIn);

      if (userState is Loaded) {
        ref.read(loggedInProvider.notifier).statusToLoaded(userState.user);
      }
    } on UtilException catch (error) {
      if (context.mounted) {
        showResultMessageSnackbar(
          context: context,
          message: error.errorMessage!,
        );
      }
    } on Exception {
      return;
    }
  }
}

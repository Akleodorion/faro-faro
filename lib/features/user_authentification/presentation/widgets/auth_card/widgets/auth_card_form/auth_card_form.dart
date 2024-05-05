import 'package:faro_clean_tdd/features/user_authentification/presentation/pages/pop_up/forgot_passord_modal.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/auto_login_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card/widgets/auth_card_form/methods/get_global_padding.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card/widgets/auth_card_form/widgets/consumer_elevated_button.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card/widgets/auth_card_form/widgets/text_form_field_column.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/constants/constants.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/methods/set_log_in_info_email_password_pref_values.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/my_text_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCardForm extends ConsumerStatefulWidget {
  const AuthCardForm({
    super.key,
  });

  @override
  ConsumerState<AuthCardForm> createState() => _AuthCardFormState();
}

class _AuthCardFormState extends ConsumerState<AuthCardForm> {
  bool logingIn = true;
  Map<String, dynamic> logInInfo = {};
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    final values = ref.read(autoLoginInfoProvider);
    logInInfo = setLogInInfoEmailPasswordPrefValues(values, logInInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getGlobalPadding(context),
              ),
              child: TextFormFieldColum(
                  logInInfo: logInInfo,
                  logingIn: logingIn,
                  onSave: (key, value) {
                    setState(() {
                      logInInfo[key] = value;
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConsumerElevatedButton(
                  logingIn: logingIn,
                  logInInfo: logInInfo,
                  formKey: formKey,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextButton(
                  text: logingIn ? Strings.createAccount : Strings.haveAccount,
                  onPressed: () {
                    setState(() {
                      logingIn = !logingIn;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (logingIn)
              MyTextButton(
                text: Strings.forgotPassword,
                onPressed: () {
                  forgotPasswordModal(context);
                },
              )
          ],
        ),
      ),
    );
  }
}

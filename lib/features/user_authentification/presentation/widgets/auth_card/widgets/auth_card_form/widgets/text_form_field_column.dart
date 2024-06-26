// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/widgets/auth_card/widgets/auth_card_form/methods/set_list_of_text_form_fields.dart';

class TextFormFieldColum extends StatelessWidget {
  const TextFormFieldColum({
    super.key,
    required this.logInInfo,
    required this.logingIn,
    required this.onSave,
  });

  final Map<String, dynamic> logInInfo;
  final bool logingIn;
  final Function(String key, String value) onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: setListOfTextFormField(
        logInInfo: logInInfo,
        isLogingIn: logingIn,
        onSave: onSave,
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Cette méthode tente de valider un formulaire
/// Elle prends en paramètre la clé du formulaire
///
/// Jette une [Exception] en cas de non validitié du formulaire.
void validateForm({
  required GlobalKey<FormState>? form,
}) {
  if (form!.currentState!.validate()) {
    form.currentState!.save();
    return;
  }
  throw Exception();
}

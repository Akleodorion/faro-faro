import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';

import '../../../../core/errors/failures.dart';

abstract class ContactRepository {
  //Récupère la liste des contacts de l'utilisateur connecté.
  Future<Either<Failure, List<Contact>>> fectchConctacts(
      {required List<String> numbers});
}

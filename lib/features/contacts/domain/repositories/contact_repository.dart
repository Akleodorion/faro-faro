// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';
import '../../../../core/errors/failures.dart';

abstract class ContactRepository {
  //Récupère la liste des contacts de l'utilisateur connecté.
  Future<Either<Failure, List<Contact>>> fectchConctacts(
      {required List<String> numbers});
}

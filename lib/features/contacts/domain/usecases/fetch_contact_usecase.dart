import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/contacts/domain/repositories/contact_repository.dart';

class FetchContactUsecase {
  final ContactRepository repository;

  FetchContactUsecase({required this.repository});

  Future<Either<Failure, List<Contact>>?>? execute(
      {required List<String> contacts}) async {
    return await repository.fectchConctacts(contacts: contacts);
  }
}

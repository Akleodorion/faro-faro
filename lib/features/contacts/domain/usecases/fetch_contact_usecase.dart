// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';
import 'package:faro_faro/features/contacts/domain/repositories/contact_repository.dart';

class FetchContactUsecase {
  final ContactRepository repository;

  FetchContactUsecase({required this.repository});

  Future<Either<Failure, List<Contact>>> execute(
      {required List<String> numbers}) async {
    return await repository.fectchConctacts(numbers: numbers);
  }
}

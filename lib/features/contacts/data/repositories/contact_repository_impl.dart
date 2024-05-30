// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/core/network/network_info.dart';
import 'package:faro_faro/features/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';
import 'package:faro_faro/features/contacts/domain/repositories/contact_repository.dart';
import 'package:faro_faro/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_faro/internal_features/contact_list/contact_list.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.contactList,
  });

  final NetworkInfo networkInfo;
  final ContactRemoteDataSource remoteDataSource;
  final ContactList contactList;

  @override
  Future<Either<Failure, List<Contact>>> fectchConctacts(
      {required List<String> numbers}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.fetchContactsInBatches(numbersList: numbers);
        return Right(result);
      } on ServerException catch (error) {
        return Left(ServerFailure(errorMessage: error.errorMessage));
      }
    } else {
      return const Left(ServerFailure(errorMessage: noInternetConnexion));
    }
  }
}

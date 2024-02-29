import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/features/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/contacts/domain/repositories/contact_repository.dart';
import 'package:faro_clean_tdd/features/members/data/repositories/member_repository_impl.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.contactList,
  });

  final NetworkInfo networkInfo;
  final ContactRemoteDataSource remoteDataSource;
  final GetContactList contactList;

  @override
  Future<Either<Failure, List<Contact>>> fectchConctacts() async {
    if (await networkInfo.isConnected) {
      try {
        final numbersList = await contactList.getContacts();
        final result = await remoteDataSource.fetchContactsInBatches(
            numbersList: numbersList);
        return Right(result);
      } on ServerException catch (error) {
        return Left(ServerFailure(errorMessage: error.errorMessage));
      }
    } else {
      return const Left(ServerFailure(errorMessage: noInternetConnexion));
    }
  }
}

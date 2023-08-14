import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/repositories/user_authentification_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import './user_authentification_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  UserRemoteDataSource,
  UserLocalDataSource,
])
void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserAuthentificationRepositoryImpl userAuthentificationRepositoryImpl;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    userAuthentificationRepositoryImpl = UserAuthentificationRepositoryImpl(
        localDataSource: mockUserLocalDataSource,
        remoteDataSource: mockUserRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  
}
